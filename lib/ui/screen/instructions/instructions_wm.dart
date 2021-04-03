import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:sleeplogger/ui/screen/home/home_route.dart';

class InstructionsWm extends WidgetModel {
  InstructionsWm(
    WidgetModelDependencies baseDependencies,
    this.navigator,
    Model model,
  ) : super(baseDependencies, model: model);

  final NavigatorState navigator;

  /// Кнопка продолжить
  final submit = Action<void>();

  @override
  void onBind() {
    super.onBind();
    subscribe(submit.stream, (t) => navigator.pushNamed(HomeRoute.routeName));
  }
}
