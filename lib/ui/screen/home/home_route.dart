import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/ui/screen/home/home_screen.dart';
import 'package:sleeplogger/ui/screen/home/home_wm.dart';
import 'package:provider/provider.dart';

class HomeRoute extends MaterialPageRoute {
  static const String routeName = 'HomeRoute';

  HomeRoute() : super(builder: (context) => HomeScreen(_wmBuilder));
}

WidgetModel _wmBuilder(BuildContext context) {
  return HomeWm(
    context.read<WidgetModelDependencies>(),
    Navigator.of(context),
  );
}
