/// Пользователь
abstract class UserRepository {
  /// Получить id пользователя
  Future<String> getId();

  /// Получить имя пользователя
  Future<String> getName();

  /// Получить email пользователя
  Future<String> getEmail();
}
