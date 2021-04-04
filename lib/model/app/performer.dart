import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/data/settings_repository/settings_repository.dart';
import 'package:sleeplogger/model/app/changes.dart';

/// Устанавливает флаг первого запуска
class SetFirstRunPerformer extends FuturePerformer<void, SetFirstRun> {
  final SettingsRepository settingsRepository;

  SetFirstRunPerformer(this.settingsRepository);

  @override
  Future<void> perform(SetFirstRun change) async {
    settingsRepository.isFirstRun = change.isFirstRun;
  }
}

/// Отдает флаг первого запуска
class GetFirstRunPerformer extends FuturePerformer<bool, GetFirstRun> {
  final SettingsRepository settingsRepository;

  GetFirstRunPerformer(this.settingsRepository);

  @override
  Future<bool> perform(GetFirstRun change) async {
    return settingsRepository.isFirstRun;
  }
}
