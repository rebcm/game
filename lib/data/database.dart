abstract class Database {
  Future<int> insert(String data);
  Future<void> update(String data);
  Future<void> commit();
  Future<void> rollback();
}
