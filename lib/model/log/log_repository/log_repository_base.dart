import 'package:sleeplogger/domain/log_entry.dart';

/// Репозиторий лога
abstract class LogRepository {
  /// Добавляет запись в конец лога
  void add(String message);

  /// Возвращает список всех записей
  List<LogEntry> all();

  /// Удалить все записи
  void clear();
}
