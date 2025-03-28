abstract base class LocalDatasource<T> {
  Future<List<T>> getAll();

  Future<int?> add(T object);

  Future<void> remove(String id);

  Future<T?> getById(String id);
}
