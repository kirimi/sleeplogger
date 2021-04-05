import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:sleeplogger/model/log/sender_service/sender_service.dart';

/// Сервис, который передает файл в Firebase cloud storage
class CloudSender implements SenderService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<bool> send(String path) async {
    File file = File(path);
    final filename = basename(path);

    _storage.setMaxUploadRetryTime(Duration(seconds: 10));
    Reference firebaseStorageRef = _storage.ref().child('logs').child(filename);
    UploadTask uploadTask = firebaseStorageRef.putFile(file);

    try {
      await uploadTask;
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }
}
