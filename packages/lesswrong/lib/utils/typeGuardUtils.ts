type Literal<T> = string extends T ? never : T;
type Tuple<T extends ReadonlyArray<string>> = Literal<T[number]> extends never ? never : T;

/**
 * We fairly frequently encounter the following pattern:
 * - we have some known set of literal values
 * - we need to check some unknown value to see if it's one of them
 * - we want to preserve type info (i.e. have that previous check act as a type guard)
 * 
 * Most ways of doing this in Typescript rely on type casts, which are fragile, since you can change something in one place but not another
 * 
 * The generic constraints here ensure that you can only pass in tuples with literal values known at compile-time, and not string arrays
 * This ensures that the type guard works as intended and doesn't silently "break" if the set is instantiated with an insufficiently-typed set of values
 * 
 * Example usage:
 * ```
 * const tabs = new TupleSet(['sunshineNewUsers', 'allUsers', 'moderatedComments'] as const);
 * type DashboardTabs = UnionOf<typeof tabs>;
 * 
 * const getCurrentView = (query: Record<string, string>): DashboardTabs => {
 *  const tabQuery = query.view; // this is type `string`
 *  if (tabs.has(tabQuery)) return tabQuery; // This is now type `DashboardTabs`
 *  else return 'sunshineNewUsers';
 * }
 * ```
 * 
 * The following will cause a type error:
 * ```
 * const tabNames = ['sunshineNewUsers', 'allUsers', 'moderatedComments'];
 * new TupleSet(tabNames); // tabNames is typed `string[]`
 * new TupleSet(['sunshineNewUsers', 'allUsers', 'moderatedComments']); // missing `as const`
 * ```
 */
export class TupleSet<T extends ReadonlyArray<string>> extends Set<string> {
  constructor(knownValues: Tuple<T>) {
    super(knownValues);
  }

  has (value: string): value is T[number] {
    return super.has(value);
  }
}

export type TupleOf<T extends TupleSet<any>> = T extends TupleSet<infer U> ? U : never;
export type UnionOf<T extends TupleSet<any>> = TupleOf<T>[number];