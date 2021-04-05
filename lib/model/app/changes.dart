import 'package:mwwm/mwwm.dart';

/// Устанавливает флаг первого запуска
class SetFirstRun extends FutureChange<void> {
  // ignore: avoid_positional_boolean_parameters
  SetFirstRun(this.isFirstRun);

  final bool isFirstRun;
}

/// Получить флаг первого запуска
class GetFirstRun extends FutureChange<bool> {}
