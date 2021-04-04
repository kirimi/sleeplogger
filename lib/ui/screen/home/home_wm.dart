import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:sleeplogger/model/app/changes.dart';
import 'package:sleeplogger/ui/screen/play/play_route.dart';

class HomeWm extends WidgetModel {
  HomeWm(
    WidgetModelDependencies baseDependencies,
    this.navigator,
    Model model,
  ) : super(baseDependencies, model: model);

  final NavigatorState navigator;

  final start = Action<void>();

  @override
  void onLoad() {
    super.onLoad();
    // Следующие запуски будут начинаться с HomeScreen.
    // см. app.dart
    model.perform(SetFirstRun(false));
  }

  @override
  void onBind() {
    super.onBind();
    subscribe(start.stream, _onStart);
  }

  void _onStart(_) {
    navigator.pushNamed(PlayRoute.routeName);
  }
}
