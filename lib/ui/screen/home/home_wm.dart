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

  /// переход на страницу home
  final enterPage = Action<void>();

  /// послать логи
  final sendLogs = Action<void>();

  /// Количество неотправленных отчетов
  final StreamedState<int> unsentFilesCount = StreamedState<int>(0);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Следующие запуски будут начинаться с HomeScreen.
    // см. app.dart
    model.perform(SetFirstRun(false));
  }

  @override
  void onBind() {
    super.onBind();
    subscribe(start.stream, _onStart);
    subscribe(bottomNavTap.stream, _onBottomNavTap);
    subscribe(enterPage.stream, _onEnterPage);
    subscribe(sendLogs.stream, _onSendLogs);
  }

  /// Нажали на кнопку старт
  Future<void> _onStart(_) async {
    navigator.pushNamed(PlayRoute.routeName);
  }

  /// Нажали на кнопку навигации внизу
  void _onBottomNavTap(int index) {
    if (index == 0) {
      navigator.pushNamed(InstructionsRoute.routeName);
    } else if (index == 1) {
      navigator.pushNamed(RegistrationRoute.routeName);
    }
  }

  /// При переходе на страницу home
  /// пробуем отправить логи
  void _onEnterPage(_) => _sendLogs();

  /// Нажали на кнопку отправить логи
  void _onSendLogs(_) => _sendLogs();

  /// Посылаем логи и обновляем интерфейс
  Future<void> _sendLogs() async {
    try {
      await model.perform(SendLogs());
    } catch (e) {}
    _updateUnsentCount();
  }

  /// Обновление счетчика неотправленных файлов
  Future<void> _updateUnsentCount() async {
    final files = await model.perform(GetUnsentLogs());
    unsentFilesCount.accept(files.length);
  }
}
