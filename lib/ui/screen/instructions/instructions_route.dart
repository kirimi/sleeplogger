import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:sleeplogger/data/settings_repository/settings_repository.dart';
import 'package:sleeplogger/model/app/performer.dart';
import 'package:sleeplogger/ui/screen/instructions/instructions_screen.dart';
import 'package:sleeplogger/ui/screen/instructions/instructions_wm.dart';

class InstructionsRoute extends MaterialPageRoute {
  static const String routeName = 'InstructionsRoute';

  InstructionsRoute()
      : super(builder: (context) => InstructionsScreen(_wmBuilder));
}

WidgetModel _wmBuilder(BuildContext context) {
  return InstructionsWm(
    context.read<WidgetModelDependencies>(),
    Navigator.of(context),
    Model([
      GetFirstRunPerformer(context.read<SettingsRepository>()),
    ]),
  );
}
