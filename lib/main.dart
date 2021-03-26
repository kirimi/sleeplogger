import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository_base.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository_mem.dart';
import 'package:sleeplogger/model/sound/sound_manager/sound_manager.dart';
import 'package:sleeplogger/ui/app.dart';
import 'package:sleeplogger/ui/error/default_error_handler.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<WidgetModelDependencies>(
          create: (context) => WidgetModelDependencies(
            errorHandler: DefaultErrorHandler(),
          ),
        ),
        Provider<LogRepository>(
          create: (_) => LogRepositoryMem(),
        ),
        Provider<SoundManager>(
          create: (context) => SoundManager(
            context.read<LogRepository>(),
          ),
          dispose: (context, soundManager) => soundManager.dispose(),
        ),
      ],
      child: App(),
    ),
  );
}
