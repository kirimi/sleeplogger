import 'dart:async';

import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:sleeplogger/model/log/changes.dart';
import 'package:sleeplogger/model/sound/changes.dart';
import 'package:sleeplogger/utils/debouncer.dart';
import 'package:wakelock/wakelock.dart';

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

  final StreamedState<List<String>> log = StreamedState([]);

  /// Подписка на логи
  StreamSubscription _logSubscription;

  final Debouncer _debouncer = Debouncer(milliseconds: 300);

  @override
  void onBind() {
    super.onBind();
    subscribe(stop.stream, _onStop);
    subscribe(tap.stream, _onTap);

    // не выключаем экран во время сессии
    Wakelock.enable();

    model.perform(PlayRandomSample());
    _logSubscription = model.perform(SubscribeLog()).listen((event) {
      log.accept(event
          .map((e) =>
              '${DateTime.fromMillisecondsSinceEpoch(e.timestamp)} - ${e.message}')
          .toList());
    });
  }

  /// Регистрируем тап по экрану
  void _onTap(_) {
    _debouncer.run(() {
      model.perform(AddLogEntry('Tap'));
    });

    registeredTaps.accept(registeredTaps.value + 1);
  }

  /// Останавливает процедуру
  void _onStop(_) {
    _logSubscription?.cancel();
    model.perform(StopAllSounds());

    // Сохраняем лог
    model.perform(SaveLogs());

    // позволяем погаснуть экрану
    Wakelock.disable();

    navigator.pop();
  }
}
