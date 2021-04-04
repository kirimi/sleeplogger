import 'package:mwwm/mwwm.dart';

/// Устанавливает флаг первого запуска
class SetFirstRun extends FutureChange<void> {
  final bool isFirstRun;

  SetFirstRun(this.isFirstRun);
}

/// Получить флаг первого запуска
class GetFirstRun extends FutureChange<bool> {}
