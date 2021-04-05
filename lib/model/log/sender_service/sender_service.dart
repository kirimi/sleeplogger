/// Базовый класс для сервисов которые посылают логи
abstract class SenderService {
  Future<bool> send(String path);
}
