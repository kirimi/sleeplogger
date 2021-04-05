import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/domain/user.dart';

/// Получить данные пользователя
class GetUser extends FutureChange<User> {}

/// Сохранить данные пользователя
class SaveUser extends FutureChange<void> {
  SaveUser(this.user);

  final User user;
}
