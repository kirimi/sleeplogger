/// Репозиторий для сохранения лога в хранилище
abstract class StorageRepository {
  Future<void> save(String filename, String data);
}
