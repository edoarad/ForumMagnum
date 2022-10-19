/* eslint-disable no-console */
import { Vulcan, getCollection } from "../vulcan-lib";
import { getSqlClientOrThrow } from "../../lib/sql/sqlClient";
import Table from "../../lib/sql/Table";
import InsertQuery from "../../lib/sql/InsertQuery";
import CreateTableQuery from "../../lib/sql/CreateTableQuery";
import CreateIndexQuery from "../../lib/sql/CreateIndexQuery";
import { forEachDocumentBatchInCollection } from "../manualMigrations/migrationUtils";
import util from "util";

// A place for nasty hacks to live...
const formatters = {
  Posts: (document: DbPost): DbPost => {
    if (typeof document.scoreExceeded75Date === "boolean") {
      document.scoreExceeded75Date = new Date(Date.now());
    }
    if (!document.title) {
      document.title = "";
    }
    return document;
  },
};

const showArray = <T>(array: T[]) => util.inspect(array, {maxArrayLength: null});

/**
 * When importing large amounts of data, you can get a decent speed boost by running
 * `SET LOCAL synchronous_commit TO OFF` before this script. This is dangerous though,
 * and be sure to switch it back on afterwards.
 */
Vulcan.mongoToSql = async (collectionName: CollectionNameString) => {
  console.log(`=== Migrating collection '${collectionName}' from Mongo to Postgres ===`);

  console.log("...Looking up collection");
  const collection = getCollection(collectionName);
  if (!collection) {
    throw new Error(`Invalid collection: ${collectionName}`);
  }

  console.log("...Building schema");
  const table = Table.fromCollection(collection);
  const schemaFields = Object.keys(collection._schemaFields);
  const tableFields = Object.keys(table.getFields());
  console.log("...Migrating fields:", showArray(tableFields));
  const skippedFields = schemaFields.filter((field) => tableFields.indexOf(field) < 0);
  if (skippedFields.length) {
    console.warn("......Warning: Skipped fields:", showArray(skippedFields));
  }

  console.log("...Creating table");
  const sql = getSqlClientOrThrow();
  try {
    const createQuery = new CreateTableQuery(table);
    const compiled = createQuery.compile();
    await sql.none(compiled.sql, compiled.args);
  } catch (e) {
    console.error("Failed to create table");
    console.log(table);
    throw e;
  }

  await sql.none(`ALTER TABLE "${table.getName()}" SET UNLOGGED`);

  console.log("...Creating indexes");
  const indexQueries = table.getIndexes().map((index) => new CreateIndexQuery(table, index));
  if (indexQueries.length === 0) {
    console.warn("...Warning: 0 indexes found: did you wait for the timeout?");
  }
  for (const indexQuery of indexQueries) {
    const compiled = indexQuery.compile();
    await sql.none(compiled.sql, compiled.args);
  }

  console.log("...Copying data");
  // The Postgres protocol stores parameter indexes as a U16, so there can't be more than 65535. The largest
  // collections have ~150 fields, so these can be safely imported in batches of 400 with a little safety
  // margin. For collections with fewer fields, it may be quicker to increase this number appropriately.
  const batchSize = 400;
  const formatData: (doc: DbObject) => DbObject = formatters[collectionName] ?? ((document) => document);
  let errorIds: string[] = [];
  let count = 0;
  await forEachDocumentBatchInCollection({
    collection,
    batchSize,
    callback: async (documents: DbObject[]) => {
      console.log(`......Migrating ${documents.length} documents from index ${count}`);
      count += batchSize;
      const query = new InsertQuery(table, documents.map(formatData), {}, {conflictStrategy: "ignore"});
      const compiled = query.compile();
      try {
        await sql.none(compiled.sql, compiled.args);
      } catch (e) {
        console.error(`ERROR IMPORTING DOCUMENT BATCH`);
        console.error(e);
        errorIds = errorIds.concat(documents.map(({_id}) => _id as string));
      }
    },
  });

  await sql.none(`ALTER TABLE "${table.getName()}" SET LOGGED`);

  if (errorIds.length) {
    console.log(`...${errorIds.length} import errors:`, errorIds);
  }

  console.log(`=== Finished migrating collection '${collectionName}' ===`);
}

export default Vulcan.mongoToSql;