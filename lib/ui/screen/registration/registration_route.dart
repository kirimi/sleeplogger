import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:sleeplogger/data/settings_repository/settings_repository.dart';
import 'package:sleeplogger/model/app/performer.dart';
import 'package:sleeplogger/model/user/performer.dart';
import 'package:sleeplogger/ui/screen/registration/registration_screen.dart';
import 'package:sleeplogger/ui/screen/registration/registration_wm.dart';

class RegistrationRoute extends MaterialPageRoute {
  RegistrationRoute()
      : super(builder: (context) => const RegistrationScreen(_wmBuilder));

  static const String routeName = 'RegistrationRoute';
}

WidgetModel _wmBuilder(BuildContext context) {
  return RegistrationWm(
    context.read<WidgetModelDependencies>(),
    Navigator.of(context),
    Model([
      GetUserPerformer(context.read<SettingsRepository>()),
      SaveUserPerformer(context.read<SettingsRepository>()),
      GetFirstRunPerformer(context.read<SettingsRepository>()),
    ]),
  );
}
