import 'package:sleeplogger/domain/log_entry.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository_base.dart';

/// Репозиторий лога
class LogRepositoryMem implements LogRepository {
  final List<LogEntry> _logs = [];

  /// Добавляет запись в конец лога
  @override
  void add(String message) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final entry = LogEntry(message, now);
    _logs.add(entry);
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
}
