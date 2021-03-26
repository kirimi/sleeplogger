import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:sleeplogger/model/log/changes.dart';
import 'package:sleeplogger/model/sound/changes.dart';

class PlayWm extends WidgetModel {
  PlayWm(
    WidgetModelDependencies baseDependencies,
    this.navigator,
    Model model,
  ) : super(baseDependencies, model: model);

  final NavigatorState navigator;

  /// Тап по рабочей области
  final tap = Action<void>();

  /// Пользователь инициировал стоп
  final stop = Action<void>();

  final StreamedState<int> registeredTaps = StreamedState(0);

  @override
  void onBind() {
    super.onBind();
    subscribe(stop.stream, _onStop);
    subscribe(tap.stream, _onTap);
    model.perform(PlayRandomSample());
  }

  /// Регистрируем тап по экрану
  void _onTap(_) {
    model.perform(AddLogEntry('Tap'));
    registeredTaps.accept(registeredTaps.value + 1);
  }

  /// Останавливает процедуру
  void _onStop(_) {
    model.perform(StopAllSounds());
    navigator.pop();
  }
}
