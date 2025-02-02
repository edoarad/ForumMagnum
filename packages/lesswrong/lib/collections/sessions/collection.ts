import schema from './schema';
import { createCollection } from '../../vulcan-lib';
import { ensureIndex } from '../../collectionIndexUtils';

export const Sessions: SessionsCollection = createCollection({
  collectionName: 'Sessions',
  dbCollectionName: 'sessions',
  typeName: 'Session',
  collectionType: 'pg',
  schema,
  logChanges: false,
});

ensureIndex(Sessions, {expires: 1});

Sessions.checkAccess = async (
  _user: DbUser|null,
  _session: DbSession,
  _context: ResolverContext|null,
  outReasonDenied: {reason?: string},
): Promise<boolean> => {
  outReasonDenied.reason = "Sessions cannot be accessed manually";
  return false;
}

export default Sessions;
