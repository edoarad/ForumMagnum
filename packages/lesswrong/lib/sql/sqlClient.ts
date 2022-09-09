let sql: SqlClient | null = null;

export const setSqlClient = (sql_: SqlClient) => sql = sql_;

export const getSqlClient = () => sql;

export const getSqlClientOrThrow = () => {
  if (!sql) {
    throw new Error("SQL Client is not initialized");
  }
  return sql;
}

export const closeSqlClient = async (client: SqlClient) => {
  await client.end({ timeout: 0 });
}
