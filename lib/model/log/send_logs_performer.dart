import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/model/log/changes.dart';
import 'package:sleeplogger/model/log/sender_service/sender_service.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository.dart';

/// Отправляет логи, которые в локальном хранилище на сервер
class SendLogsPerformer extends FuturePerformer<void, SendLogs> {
  SendLogsPerformer(
      {@required this.senderService, @required this.storageRepository})
      : assert(senderService != null && storageRepository != null);

  final StorageRepository storageRepository;
  final SenderService senderService;

  @override
  Future<void> perform(SendLogs change) async {
    final files = await storageRepository.list();
    if (files.isNotEmpty) {
      for (final file in files) {
        final success = await senderService.send(file);
        if (success) {
          await storageRepository.delete(file);
        }
      }
    }
  }
}
