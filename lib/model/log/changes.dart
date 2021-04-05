import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/domain/event_type.dart';
import 'package:sleeplogger/domain/log_entry.dart';

/// Добавить запись в лог
class AddLogEntry extends FutureChange<void> {
  AddLogEntry(this.type, this.message);

  final EventType type;
  final String message;
}

/// Подписаться на обновления логов
class SubscribeLog extends StreamChange<List<LogEntry>> {}

/// Сохранить лог
class SaveLogs extends FutureChange<void> {}

/// Отправить логи на сервера
class SendLogs extends FutureChange<void> {}
