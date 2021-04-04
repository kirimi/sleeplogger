import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeplogger/data/settings_repository/settings_repository.dart';
import 'package:sleeplogger/domain/gender.dart';

/// репозиторий настроек приложения
class SettingsRepositorySharedPrefs implements SettingsRepository {
  static SettingsRepositorySharedPrefs _instance;
  static SharedPreferences _pref;

  static Future<SettingsRepositorySharedPrefs> getInstance() async {
    _instance ??= SettingsRepositorySharedPrefs();
    _pref ??= await SharedPreferences.getInstance();
    return _instance;
  }

  static const String _userIdKey = 'userIdKey';
  static const String _usernameKey = 'usernameKey';
  static const String _ageKey = 'ageKey';
  static const String _emailKey = 'emailKey';
  static const String _genderKey = 'genderKey';
  static const String _isFirstRunKey = 'isFirstRunKey';

  /// Id пользователя
  @override
  String get userId => _pref.getString(_userIdKey) ?? '';

  @override
  set userId(String value) => _pref.setString(_userIdKey, value);

  /// Имя пользователя
  @override
  String get username => _pref.getString(_usernameKey) ?? '';

  @override
  set username(String value) => _pref.setString(_usernameKey, value);

  /// Возраст пользователя
  /// Возвращает -1, если не задано
  @override
  int get age => _pref.getInt(_ageKey) ?? -1;

  @override
  set age(int value) => _pref.setInt(_ageKey, value);

  /// Email пользователя
  @override
  String get email => _pref.getString(_emailKey) ?? '';

  @override
  set email(String value) => _pref.setString(_emailKey, value);

  /// Пол пользователя
  @override
  Gender get gender {
    final bool value = _pref.getBool(_genderKey);
    if (value == null) {
      return null;
    }
    return value ? Gender.male : Gender.female;
  }

  @override
  set gender(Gender value) {
    if (value != null) {
      _pref.setBool(_genderKey, value == Gender.male);
    }
  }

  /// Первый запуск
  @override
  bool get isFirstRun => _pref.getBool(_isFirstRunKey) ?? true;

  @override
  set isFirstRun(bool value) => _pref.setBool(_isFirstRunKey, value);
}
