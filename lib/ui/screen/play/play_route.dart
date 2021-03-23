import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository_base.dart';
import 'package:sleeplogger/model/log/performer.dart';
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
      ],
    ),
  );
}
