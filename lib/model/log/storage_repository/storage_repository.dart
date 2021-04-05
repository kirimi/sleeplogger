/// Репозиторий для сохранения лога в хранилище
abstract class StorageRepository {
  Future<String> read(String path);

  Future<String> save(String filename, String data);

  Future<List<String>> list();

  Future<void> delete(String path);
}
