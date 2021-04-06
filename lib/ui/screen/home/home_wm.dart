import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:sleeplogger/model/app/changes.dart';
import 'package:sleeplogger/model/log/changes.dart';
import 'package:sleeplogger/ui/screen/instructions/instructions_route.dart';
import 'package:sleeplogger/ui/screen/play/play_route.dart';
import 'package:sleeplogger/ui/screen/registration/registration_route.dart';

class HomeWm extends WidgetModel {
  HomeWm(
    WidgetModelDependencies baseDependencies,
    this.navigator,
    Model model,
  ) : super(baseDependencies, model: model);

  final NavigatorState navigator;

  /// Кнопка старт
  final start = Action<void>();

  /// Нижнее меню
  final bottomNavTap = Action<int>();

  @override
  void onLoad() {
    super.onLoad();
    // Следующие запуски будут начинаться с HomeScreen.
    // см. app.dart
    model.perform(SetFirstRun(false));

    // Отправляем старые логи
    model.perform(SendLogs());
  }

  @override
  void onBind() {
    super.onBind();
    subscribe(start.stream, _onStart);
    subscribe(bottomNavTap.stream, _onBottomNavTap);
  }

  /// Нажали на кнопку старт
  Future<void> _onStart(_) async {
    // по возвращении пробуем отправить логи
    navigator.pushNamed(PlayRoute.routeName).then(
          (value) => model.perform(SendLogs()),
        );
  }

  /// Нажали на кнопку навигации внизу
  void _onBottomNavTap(int index) {
    if (index == 0) {
      navigator.pushNamed(InstructionsRoute.routeName);
    } else if (index == 1) {
      navigator.pushNamed(RegistrationRoute.routeName);
    }
  }
}
