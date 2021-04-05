import 'package:mwwm/mwwm.dart';

/// Обработчик ошибок для mwwm
class DefaultErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    // ignore: avoid_print
    print('Error: $e');
  }
}
