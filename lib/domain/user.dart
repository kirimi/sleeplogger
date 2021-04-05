import 'package:sleeplogger/domain/gender.dart';

/// пользователь
class User {
  User({
    this.name,
    this.email,
    this.age,
    this.gender,
  });

  final String name;
  final String email;
  final int age;
  final Gender gender;
}
