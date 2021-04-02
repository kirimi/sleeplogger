import 'package:sleeplogger/model/user/user_repository/user_repository.dart';

class UserRepositorySharedPrefs extends UserRepository {
  @override
  Future<String> getEmail() {
    return Future.value("kirill.mironov@gmail.com");
  }

  @override
  Future<String> getId() {
    return Future.value("123445678990");
  }

  @override
  Future<String> getName() {
    return Future.value("Kirill Mironov");
  }
}
