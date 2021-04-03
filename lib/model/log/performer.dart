import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/domain/event_type.dart';
import 'package:sleeplogger/domain/log_entry.dart';
import 'package:sleeplogger/model/log/changes.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository_base.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository_base.dart';
import 'package:sleeplogger/model/user/user_repository/user_repository.dart';
import 'package:sleeplogger/utils/round_double.dart';

/// Добавляет запись в репозиторий
class AddLogEntryPerformer extends FuturePerformer<void, AddLogEntry> {
  final LogRepository repository;

  AddLogEntryPerformer(this.repository);

  @override
  Future<void> perform(AddLogEntry change) async {
    repository.add(change.type, change.message);
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

    final StringBuffer data =
        StringBuffer('$userName <$userEmail>, id: $userId\n\n');

    data.writeln(_prepareLog());

    final now = DateTime.now().toString();
    final filename = '$now\_$userName\_$userId';

    storageRepository.save(filename, data.toString());

    logRepository.clear();
  }

  /// Делает временные отметки относительно начала лога
  /// Оставляет только первый тап, остальное удаляет.
  String _prepareLog() {
    final logs = logRepository.all();

    if (logs.isEmpty) {
      return '';
    }

    final startTs = logs[0].timestamp;

    final result = StringBuffer();

    final startDateTime = DateTime.fromMillisecondsSinceEpoch(startTs);
    result.writeln('Start date: $startDateTime\n');

    for (var i = 0; i < logs.length; i++) {
      final tsDelta = roundDouble(
          Duration(milliseconds: logs[i].timestamp - startTs).inMilliseconds /
              1000,
          1);

      switch (logs[i].type) {
        case EventType.start:
        case EventType.stop:
        case EventType.signal:
          result.writeln('+${tsDelta}s ${logs[i].message}');
          break;
        case EventType.tap:
          if (i != 0 && logs[i - 1].type != EventType.tap) {
            result.writeln('+${tsDelta}s ${logs[i].message}');
          }
          break;
      }
    }
    return result.toString();
  }
}
