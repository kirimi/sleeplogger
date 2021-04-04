import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository.dart';
import 'package:sleeplogger/model/log/performer.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository.dart';
import 'package:sleeplogger/model/sound/performer.dart';
import 'package:sleeplogger/model/sound/sound_manager/sound_manager.dart';
import 'package:sleeplogger/model/user/user_repository/user_repository.dart';
import 'package:sleeplogger/ui/screen/play/play_screen.dart';
import 'package:sleeplogger/ui/screen/play/play_wm.dart';

class PlayRoute extends MaterialPageRoute {
  static const String routeName = 'PlayRoute';

  PlayRoute() : super(builder: (context) => PlayScreen(_wmBuilder));
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
          userRepository: context.read<UserRepository>(),
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
