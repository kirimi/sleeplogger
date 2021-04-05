import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:sleeplogger/data/settings_repository/settings_repository.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository.dart';
import 'package:sleeplogger/model/log/performer.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository.dart';
import 'package:sleeplogger/model/sound/performer.dart';
import 'package:sleeplogger/model/sound/sound_manager/sound_manager.dart';
import 'package:sleeplogger/ui/screen/play/play_screen.dart';
import 'package:sleeplogger/ui/screen/play/play_wm.dart';

class PlayRoute extends MaterialPageRoute {
  PlayRoute() : super(builder: (context) => const PlayScreen(_wmBuilder));

  static const String routeName = 'PlayRoute';
}

WidgetModel _wmBuilder(BuildContext context) {
  return PlayWm(
    context.read<WidgetModelDependencies>(),
    Navigator.of(context),
    Model(
      [
        AddLogEntryPerformer(context.read<LogRepository>()),
        LogStreamPerformer(context.read<LogRepository>()),
        SaveLogsPerformer(
          logRepository: context.read<LogRepository>(),
          storageRepository: context.read<StorageRepository>(),
          settingsRepository: context.read<SettingsRepository>(),
        ),
        PlayRandomSamplePerformer(
          soundManager: context.read<SoundManager>(),
        ),
        StopAllSoundsPerformer(
          soundManager: context.read<SoundManager>(),
        ),
      ],
    ),
  );
}
