import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/model/log/changes.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository.dart';

/// Отдает список неотправленных файлов
class GetUnsentLogsPerformer
    extends FuturePerformer<List<String>, GetUnsentLogs> {
  GetUnsentLogsPerformer(this.storageRepository);

  final StorageRepository storageRepository;

  @override
  Future<List<String>> perform(GetUnsentLogs change) async {
    return storageRepository.list();
  }
}
