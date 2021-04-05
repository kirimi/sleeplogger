import 'dart:async';

/// Позволяет выполнять [action] не чаще чем [milliseconds]
///
/// Остальные вызовы игнорируются
///
/// ```dart
/// Debouncer _debouncer = Debouncer(milliseconds: 300);
/// _debouncer.run(() {
///   model.perform(AddLogEntry('Tap'));
/// });
/// ```
class Debouncer {
  Debouncer({this.milliseconds});

  final int milliseconds;

  Function action;
  Timer _timer;

  void run(Function action) {
    if (_timer == null) {
      action();
      _timer = Timer(Duration(milliseconds: milliseconds), () {
        _timer.cancel();
        _timer = null;
      });
    }
  }
}
