import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/domain/log_entry.dart';
import 'package:sleeplogger/model/log/changes.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository_base.dart';

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
