import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/domain/log_entry.dart';
import 'package:sleeplogger/model/log/changes.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository_base.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository_base.dart';
import 'package:sleeplogger/model/user/user_repository/user_repository.dart';

/// Добавляет запись в репозиторий
class AddLogEntryPerformer extends FuturePerformer<void, AddLogEntry> {
  final LogRepository repository;

  AddLogEntryPerformer(this.repository);

  @override
  Future<void> perform(AddLogEntry change) async {
    repository.add(change.message);
  }
}

/// Подписка на обновления логов
class LogStreamPerformer extends StreamPerformer<List<LogEntry>, SubscribeLog> {
  final LogRepository repository;

  LogStreamPerformer(this.repository);

  @override
  Stream<List<LogEntry>> perform(SubscribeLog change) {
    return repository.logStream;
  }
}

/// Сохранение логов и очистка
class SaveLogsPerformer extends FuturePerformer<void, SaveLogs> {
  final LogRepository logRepository;
  final StorageRepository storageRepository;
  final UserRepository userRepository;

  SaveLogsPerformer({
    @required this.logRepository,
    @required this.storageRepository,
    @required this.userRepository,
  })  : assert(logRepository != null),
        assert(storageRepository != null),
        assert(userRepository != null);

  @override
  Future<void> perform(SaveLogs change) async {
    final userId = await userRepository.getId();
    final userName = await userRepository.getName();
    final userEmail = await userRepository.getEmail();

    final now = DateTime.now().toString();

    final StringBuffer data =
        StringBuffer('$userName <$userEmail>, id: $userId\nDate: $now\n\n');
    for (final entry in logRepository.all()) {
      final datetime = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);
      data.writeln('$datetime;${entry.message}');
    }

    final filename = '$now\_$userName\_$userId';

    storageRepository.save(filename, data.toString());

    logRepository.clear();
  }
}
