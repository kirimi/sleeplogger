import 'package:mwwm/mwwm.dart';

/// Добавить запись в лог
class AddLogEntry extends FutureChange<void> {
  final String message;

  AddLogEntry(this.message);
}
