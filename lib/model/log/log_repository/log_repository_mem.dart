import 'dart:async';

import 'package:sleeplogger/domain/event_type.dart';
import 'package:sleeplogger/domain/log_entry.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository.dart';

/// Репозиторий лога
class LogRepositoryMem implements LogRepository {
  final List<LogEntry> _logs = [];

  final StreamController<List<LogEntry>> _logStreamController =
      StreamController.broadcast();

  @override
  Stream<List<LogEntry>> get logStream => _logStreamController.stream;

  /// Добавляет запись в конец лога
  @override
  void add(EventType type, String message) {
    final int now = DateTime.now().millisecondsSinceEpoch;
    final entry = LogEntry(type: type, message: message, timestamp: now);
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
