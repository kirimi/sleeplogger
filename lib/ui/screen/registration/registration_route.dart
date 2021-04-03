import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:sleeplogger/ui/screen/registration/registration_screen.dart';
import 'package:sleeplogger/ui/screen/registration/registration_wm.dart';

class RegistrationRoute extends MaterialPageRoute {
  static const String routeName = 'RegistrationRoute';

  RegistrationRoute()
      : super(builder: (context) => RegistrationScreen(_wmBuilder));
}

WidgetModel _wmBuilder(BuildContext context) {
  return RegistrationWm(
    context.read<WidgetModelDependencies>(),
    Navigator.of(context),
    Model([]),
  );
}
