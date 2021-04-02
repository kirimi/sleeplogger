import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/domain/log_entry.dart';

/// Добавить запись в лог
class AddLogEntry extends FutureChange<void> {
  final String message;

  AddLogEntry(this.message);
}

/// Подписаться на обновления логов
class SubscribeLog extends StreamChange<List<LogEntry>> {}

/// Сохранить лог
class SaveLogs extends FutureChange<void> {}
