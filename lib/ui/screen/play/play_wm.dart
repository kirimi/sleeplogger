import 'dart:async';

import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:sleeplogger/domain/event_type.dart';
import 'package:sleeplogger/domain/time_duration.dart';
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

  /// Таймер обратного отсчета
  final StreamedState<String> timer = StreamedState('');

  /// Лог
  final StreamedState<List<String>> log = StreamedState([]);

  /// Счетчик зарегистрированных тапов
  final StreamedState<int> registeredTaps = StreamedState(0);

  /// Время сессии, 60 минут
  static const int _sessionDurationSeconds = 3599;

  /// Таймер сессии
  Timer _timer;

  /// Подписка на логи
  StreamSubscription _logSubscription;

  /// Debouncer позволяет регистрировать тапы не чаще чем раз в 300ms
  final Debouncer _debouncer = Debouncer(milliseconds: 300);

  @override
  void onLoad() {
    super.onLoad();
    // не выключаем экран во время сессии
    Wakelock.enable();

    _setEnabledSystemUI(false);

    _timer = Timer.periodic(const Duration(seconds: 1), _onTimer);
    _updateTimer(_sessionDurationSeconds);

    model.perform(PlayRandomSample());
    _logSubscription = model.perform(SubscribeLog()).listen((event) {
      log.accept(event
          .map((e) =>
              '${DateTime.fromMillisecondsSinceEpoch(e.timestamp)} - ${e.message}')
          .toList());
    });
  }

  @override
  void onBind() {
    super.onBind();
    subscribe(stop.stream, _onStop);
    subscribe(tap.stream, _onTap);
  }

  /// Регистрируем тап по экрану
  void _onTap(_) {
    _debouncer.run(() {
      model.perform(AddLogEntry(EventType.tap, 'Tap'));
    });

    registeredTaps.accept(registeredTaps.value + 1);
  }

  /// Останавливает процедуру
  Future<void> _onStop(_) async {
    _timer?.cancel();
    _logSubscription?.cancel();

    await model.perform(StopAllSounds());

    // Сохраняем лог
    await model.perform(SaveLogs());

    // позволяем погаснуть экрану
    Wakelock.disable();

    _setEnabledSystemUI(true);

    navigator.pop();
  }

  /// Вызывается при тике таймера
  void _onTimer(Timer t) {
    final secondsLeft = _sessionDurationSeconds - t.tick;

    if (secondsLeft == 0) {
      _onStop(null);
    } else {
      _updateTimer(secondsLeft);
    }
  }

  /// Обновление таймера на ui
  void _updateTimer(int seconds) {
    final timeDuration = TimeDuration.fromSeconds(seconds);
    final min = timeDuration.minutes.toString().padLeft(2, '0');
    final sec = timeDuration.seconds.toString().padLeft(2, '0');

    final timerString = '$min:$sec';
    timer.accept(timerString);
  }

  /// Показывает или скрывает системные бары
  void _setEnabledSystemUI(bool enabled) {
    SystemChrome.setEnabledSystemUIOverlays([
      if (enabled) ...[
        SystemUiOverlay.bottom,
        SystemUiOverlay.top,
      ]
    ]);
  }

  @override
  void dispose() {
    _logSubscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }
}
