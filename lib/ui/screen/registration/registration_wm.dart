import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:sleeplogger/domain/gender.dart';
import 'package:sleeplogger/domain/user.dart';
import 'package:sleeplogger/model/app/changes.dart';
import 'package:sleeplogger/model/user/changes.dart';
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
  void onLoad() {
    super.onLoad();
    _initTextFields();
  }

  @override
  void onBind() {
    super.onBind();
    subscribe(setGender.stream, _onSetGender);
    subscribe(skip.stream, _onSkip);
    subscribe(submit.stream, _onSubmit);
  }

  /// Загружает сохраненные данные в форму
  Future<void> _initTextFields() async {
    final user = await model.perform(GetUser());
    name.controller.text = user.name;
    email.controller.text = user.email;
    if (user.age != -1) {
      age.controller.text = user.age.toString();
    }
    gender.accept(user.gender);
  }

  /// При выборе пола
  void _onSetGender(value) => gender.accept(value);

  /// Нажали пропустить
  void _onSkip(_) => _goNextPage();

  /// нажали продолжить
  Future<void> _onSubmit(_) async {
    final user = User(
      name: name.value,
      email: email.value,
      age: _parseAge(age.value),
      gender: gender.value,
    );
    model.perform(SaveUser(user));

    _goNextPage();
  }

  /// Возвращает возраст int или -1, если не распарсить в int
  int _parseAge(String ageString) {
    int ageInt;
    if (age.value != null) {
      ageInt = int.tryParse(age.value);
    }
    return ageInt ?? -1;
  }

  /// Переход на следующую страницу если это первых запуск
  /// или возврат на предыдущую, если попали сюда с home
  Future<void> _goNextPage() async {
    final bool isFirstRun = await model.perform(GetFirstRun());

    if (isFirstRun) {
      navigator.pushReplacementNamed(InstructionsRoute.routeName);
    } else {
      navigator.pop();
    }
  }
}
