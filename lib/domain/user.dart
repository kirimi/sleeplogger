import 'package:sleeplogger/domain/gender.dart';

/// пользователь
class User {
  final String name;
  final String email;
  final int age;
  final Gender gender;

  User({
    this.name,
    this.email,
    this.age,
    this.gender,
  });
}
