import 'package:sleeplogger/domain/event_type.dart';
import 'package:sleeplogger/domain/log_entry.dart';

/// Репозиторий лога
abstract class LogRepository {
  Stream<List<LogEntry>> get logStream;

  /// Добавляет запись в конец лога
  void add(EventType type, String message);

  /// Возвращает список всех записей
  List<LogEntry> all();

  /// Удалить все записи
  void clear();

  void dispose();
}
