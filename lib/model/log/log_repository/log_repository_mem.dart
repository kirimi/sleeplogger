import 'dart:async';

import 'package:sleeplogger/domain/log_entry.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository_base.dart';

/// Репозиторий лога
class LogRepositoryMem implements LogRepository {
  final List<LogEntry> _logs = [];

  final StreamController _logStreamController =
      StreamController<List<LogEntry>>.broadcast();

  @override
  Stream<List<LogEntry>> get logStream => _logStreamController.stream;

  /// Добавляет запись в конец лога
  @override
  void add(String message) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final entry = LogEntry(message, now);
    _logs.add(entry);
    _logStreamController.sink.add(_logs);
  }

  /// Возвращает список всех записей
  @override
  List<LogEntry> all() {
    return _logs;
  }

  /// Удалить все записи
  @override
  void clear() {
    _logs.clear();
  }

  @override
  void dispose() {
    _logStreamController.close();
  }
}
