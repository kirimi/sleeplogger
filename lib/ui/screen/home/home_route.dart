import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:sleeplogger/data/settings_repository/settings_repository.dart';
import 'package:sleeplogger/model/app/performer.dart';
import 'package:sleeplogger/ui/screen/home/home_screen.dart';
import 'package:sleeplogger/ui/screen/home/home_wm.dart';

class HomeRoute extends MaterialPageRoute {
  static const String routeName = 'HomeRoute';

  HomeRoute() : super(builder: (context) => HomeScreen(_wmBuilder));
}

WidgetModel _wmBuilder(BuildContext context) {
  return HomeWm(
    context.read<WidgetModelDependencies>(),
    Navigator.of(context),
    Model([
      SetFirstRunPerformer(context.read<SettingsRepository>()),
    ]),
  );
}
