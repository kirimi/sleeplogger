import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/data/settings_repository/settings_repository.dart';
import 'package:sleeplogger/domain/event_type.dart';
import 'package:sleeplogger/domain/gender.dart';
import 'package:sleeplogger/domain/log_entry.dart';
import 'package:sleeplogger/model/log/changes.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository.dart';
import 'package:sleeplogger/utils/round_double.dart';

/// Добавляет запись в репозиторий
class AddLogEntryPerformer extends FuturePerformer<void, AddLogEntry> {
  AddLogEntryPerformer(this.repository);

  final LogRepository repository;

  @override
  Future<void> perform(AddLogEntry change) async {
    repository.add(change.type, change.message);
  }
}

/// Подписка на обновления логов
class LogStreamPerformer extends StreamPerformer<List<LogEntry>, SubscribeLog> {
  LogStreamPerformer(this.repository);

  final LogRepository repository;

  @override
  Stream<List<LogEntry>> perform(SubscribeLog change) {
    return repository.logStream;
  }
}

/// Сохранение логов и очистка
class SaveLogsPerformer extends FuturePerformer<void, SaveLogs> {
  SaveLogsPerformer({
    @required this.logRepository,
    @required this.storageRepository,
    @required this.settingsRepository,
  })  : assert(logRepository != null),
        assert(storageRepository != null),
        assert(settingsRepository != null);

  final LogRepository logRepository;
  final StorageRepository storageRepository;
  final SettingsRepository settingsRepository;

  @override
  Future<void> perform(SaveLogs change) async {
    final userId = settingsRepository.userId;
    final userName = settingsRepository.username;
    final userEmail = settingsRepository.email;
    final userAge = settingsRepository.age;
    final userGender = settingsRepository.gender;

    final StringBuffer data = StringBuffer();

    if (userId.isNotEmpty) {
      data.writeln('UserId: $userId');
    }
    if (userName.isNotEmpty) {
      data.writeln('Name: $userName');
    }
    if (userEmail.isNotEmpty) {
      data.writeln('Email: $userEmail');
    }
    if (userAge != -1) {
      data.writeln('Age: $userAge');
    }
    if (userGender != null) {
      data.writeln('Gender: ${userGender == Gender.male ? 'Male' : 'Female'}');
    }

    data.writeln('');

    data.writeln(_prepareLog());

    final now = DateTime.now().toString();
    final filename = '$now-$userName-$userId';

    await storageRepository.save(filename, data.toString());

    logRepository.clear();
  }

  /// Делает временные отметки относительно начала лога
  /// Оставляет только первый тап, остальное удаляет.
  String _prepareLog() {
    final List<LogEntry> logs = logRepository.all();
    final List<LogEntry> cleanedLogs = [];

    if (logs.isEmpty) {
      return '';
    }

    // Очищаем лог от лишних тапов. Оставляем только первый тап
    for (var i = 0; i < logs.length; i++) {
      switch (logs[i].type) {
        case EventType.start:
        case EventType.stop:
        case EventType.signal:
          cleanedLogs.add(logs[i]);
          break;
        case EventType.tap:
          if (i != 0 && logs[i - 1].type != EventType.tap) {
            cleanedLogs.add(logs[i]);
          }
          break;
      }
    }

    final result = StringBuffer();

    final startTs = cleanedLogs[0].timestamp;
    final startDateTime = DateTime.fromMillisecondsSinceEpoch(startTs);
    result.writeln('Start date: $startDateTime\n');

    for (var i = 0; i < cleanedLogs.length; i++) {
      final tsDelta =
          roundDouble((cleanedLogs[i].timestamp - startTs) / 1000, 1);

      switch (cleanedLogs[i].type) {
        case EventType.start:
          result.write('\n$tsDelta\t${cleanedLogs[i].message}');
          break;
        case EventType.stop:
          result.write('\n$tsDelta\t${cleanedLogs[i].message}');
          break;
        case EventType.signal:
          result.write('\n$tsDelta\t${cleanedLogs[i].message}');
          break;
        case EventType.tap:
          result.write('\t$tsDelta\t${cleanedLogs[i].message}');
          break;
      }
    }
    return result.toString();
  }
}
