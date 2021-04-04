import 'package:firebase_storage/firebase_storage.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository.dart';

/// Репозиторий для сохранения лога в хранилище
///
/// Сохраняет в Firebase Cloud storage
class StorageRepositoryCloud implements StorageRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<void> save(String filename, String data) async {
    try {
      await _storage
          .ref('logs/$filename.log')
          .putString(data, format: PutStringFormat.raw);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }
}
