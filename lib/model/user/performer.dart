import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/data/settings_repository/settings_repository.dart';
import 'package:sleeplogger/domain/user.dart';
import 'package:sleeplogger/model/user/changes.dart';

/// Сохранение данных пользователя
class SaveUserPerformer extends FuturePerformer<void, SaveUser> {
  SaveUserPerformer(this.settingsRepository);

  final SettingsRepository settingsRepository;

  @override
  Future<void> perform(SaveUser change) async {
    settingsRepository.username = change.user.name;
    settingsRepository.email = change.user.email;
    settingsRepository.age = change.user.age;
    settingsRepository.gender = change.user.gender;
  }
}

/// Получение данных пользователя
class GetUserPerformer extends FuturePerformer<User, GetUser> {
  GetUserPerformer(this.settingsRepository);

  final SettingsRepository settingsRepository;

  @override
  Future<User> perform(GetUser change) {
    final user = User(
      name: settingsRepository.username,
      email: settingsRepository.email,
      age: settingsRepository.age,
      gender: settingsRepository.gender,
    );
    return Future.value(user);
  }
}
