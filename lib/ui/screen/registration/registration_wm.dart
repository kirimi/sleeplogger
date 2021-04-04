import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:sleeplogger/domain/gender.dart';
import 'package:sleeplogger/ui/screen/instructions/instructions_route.dart';

class RegistrationWm extends WidgetModel {
  RegistrationWm(
    WidgetModelDependencies baseDependencies,
    this.navigator,
    Model model,
  ) : super(baseDependencies, model: model);

  final NavigatorState navigator;

  /// Radiobutton пол
  final StreamedState gender = StreamedState<Gender>();
  final setGender = Action<Gender>();

  /// Поля ввода формы
  final name = TextEditingAction();
  final email = TextEditingAction();
  final age = TextEditingAction();

  /// Кнопка пропустить
  final skip = Action<void>();

  /// Кнопка продолжить
  final submit = Action<void>();

  @override
  void onBind() {
    super.onBind();
    subscribe(setGender.stream, _onSetGender);
    subscribe(skip.stream, _onSkip);
    subscribe(submit.stream, _onSubmit);
  }

  /// При выборе пола
  void _onSetGender(value) => gender.accept(value);

  /// Нажали пропустить
  void _onSkip(_) => navigator.pushNamed(InstructionsRoute.routeName);

  /// нажали продолжить
  void _onSubmit(_) {
    // todo сохранить данные
    navigator.pushNamed(InstructionsRoute.routeName);
  }
}
