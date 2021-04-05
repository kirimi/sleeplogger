import 'package:sleeplogger/model/log/sender_service/cloud_sender.dart';
import 'package:sleeplogger/model/log/sender_service/email_sender/email_sender.dart';
import 'package:sleeplogger/model/log/sender_service/sender_service.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository.dart';

/// Сервис отправляет файл по почте и в облако
class CompositeSender implements SenderService {
  CompositeSender(StorageRepository storageRepository) {
    _cloudSender = CloudSender();
    _emailSender = EmailSender(storageRepository);
  }

  CloudSender _cloudSender;
  EmailSender _emailSender;

  @override
  Future<bool> send(String path) async {
    _cloudSender.send(path);
    return _emailSender.send(path);
  }
}
