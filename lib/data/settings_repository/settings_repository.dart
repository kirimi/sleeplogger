import 'package:sleeplogger/domain/gender.dart';

/// репозиторий настроек приложения
abstract class SettingsRepository {
  /// ID пользователя
  String userId;

  /// Имя пользователя
  String username;

  /// Email пользователя
  String email;

  /// Возраст пользователя
  int age;

  /// Пол пользователя
  Gender gender;

  /// Первый запуск приложения
  bool isFirstRun;
}
