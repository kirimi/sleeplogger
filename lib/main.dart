import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository_mem.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository_cloud.dart';
import 'package:sleeplogger/model/sound/sound_manager/sound_manager.dart';
import 'package:sleeplogger/model/user/user_repository/user_repository.dart';
import 'package:sleeplogger/model/user/user_repository/user_repository_sharedprefs.dart';
import 'package:sleeplogger/ui/app.dart';
import 'package:sleeplogger/ui/error/default_error_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runZonedGuarded(() {
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
          Provider<StorageRepository>(
            create: (_) => StorageRepositoryCloud(),
          ),
          Provider<UserRepository>(
            create: (_) => UserRepositorySharedPrefs(),
          ),
        ],
        child: App(),
      ),
    );
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
