import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:sleeplogger/data/settings_repository/settings_repository.dart';
import 'package:sleeplogger/data/settings_repository/settings_repository_sharedpref.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository_mem.dart';
import 'package:sleeplogger/model/log/sender_service/composite_sender.dart';
import 'package:sleeplogger/model/log/sender_service/sender_service.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository_local.dart';
import 'package:sleeplogger/model/sound/sound_manager/sound_manager.dart';
import 'package:sleeplogger/ui/app.dart';
import 'package:sleeplogger/ui/error/default_error_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final settingsRepository = await SettingsRepositorySharedPrefs.getInstance();

  // Устанавливаем userId как id устройства
  if (settingsRepository.userId.isEmpty) {
    final deviceId = await PlatformDeviceId.getDeviceId;
    settingsRepository.userId = deviceId;
  }

  runZonedGuarded(() {
    runApp(
      MultiProvider(
        providers: [
          Provider<RouteObserver>(
            create: (_) => RouteObserver<PageRoute>(),
          ),
          Provider<SettingsRepository>(
            create: (_) => settingsRepository,
          ),
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
            create: (_) => StorageRepositoryLocal(),
          ),
          Provider<SenderService>(
            create: (context) => CompositeSender(
              context.read<StorageRepository>(),
            ),
          ),
        ],
        child: App(),
      ),
    );
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
