abstract class LocalDatasource<T> {
  Future<List<T>> getAll();

  Future<T?> add(T object);

  Future<void> edit(T object,bool Function(T key) where);

  Future<void> remove(String id);

  Future<T?> getById(String id);
}
