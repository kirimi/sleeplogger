import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:sleeplogger/data/settings_repository/settings_repository.dart';
import 'package:sleeplogger/model/app/performer.dart';
import 'package:sleeplogger/model/log/send_logs_performer.dart';
import 'package:sleeplogger/model/log/sender_service/sender_service.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository.dart';
import 'package:sleeplogger/ui/screen/home/home_screen.dart';
import 'package:sleeplogger/ui/screen/home/home_wm.dart';

class HomeRoute extends MaterialPageRoute {
  HomeRoute() : super(builder: (context) => const HomeScreen(_wmBuilder));

  static const String routeName = 'HomeRoute';
}

WidgetModel _wmBuilder(BuildContext context) {
  return HomeWm(
    context.read<WidgetModelDependencies>(),
    Navigator.of(context),
    Model([
      SetFirstRunPerformer(context.read<SettingsRepository>()),
      SendLogsPerformer(
        senderService: context.read<SenderService>(),
        storageRepository: context.read<StorageRepository>(),
      ),
    ]),
  );
}
