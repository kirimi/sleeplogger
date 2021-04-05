import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:sleeplogger/model/log/sender_service/sender_service.dart';

/// Сервис, который передает файл в Firebase cloud storage
class CloudSender implements SenderService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<bool> send(String path) async {
    final file = File(path);
    final filename = basename(path);

    _storage.setMaxUploadRetryTime(const Duration(seconds: 10));
    final firebaseStorageRef = _storage.ref().child('logs').child(filename);
    final uploadTask = firebaseStorageRef.putFile(file);

    try {
      await uploadTask;
      return true;
    } on FirebaseException catch (_) {
      return false;
    }
  }
}
