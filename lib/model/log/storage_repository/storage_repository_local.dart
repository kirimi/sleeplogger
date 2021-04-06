import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository.dart';

/// Репозиторий для сохранения логов в локальной ФС
class StorageRepositoryLocal implements StorageRepository {
  /// Возвращает содержимое файла [path] в строке
  @override
  Future<String> read(String path) async {
    final file = File(path);
    final contents = await file.readAsString();
    return contents;
  }

  /// Созраняет файл с именем [filename] и содержимом [data]
  @override
  Future<String> save(String filename, String data) async {
    final rootDir = await getApplicationDocumentsDirectory();
    final file = await File('${rootDir.path}/logs/$filename.log')
        .create(recursive: true);
    await file.writeAsString(data);
    return file.path;
  }

  /// Возвращает список файлов с полными путями
  @override
  Future<List<String>> list() async {
    final rootDir = await getApplicationDocumentsDirectory();
    final path = '${rootDir.path}/logs/';
    final dir = Directory(path);
    final files = <String>[];

    final completer = Completer<List<String>>();

    if (!(await dir.exists())) {
      completer.complete(files);
      return completer.future;
    }

    final lister = dir.list(recursive: false);
    lister.listen(
      (file) => files.add(file.path),
      onDone: () => completer.complete(files),
    );
    return completer.future;
  }

  /// Удаляет файл [path]
  @override
  Future<void> delete(String path) async {
    final file = File(path);
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }
}
