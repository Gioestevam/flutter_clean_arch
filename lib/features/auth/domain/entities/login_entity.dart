import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  String email;
  String password;

  LoginEntity({
    required this.email,
    required this.password
  });

  @override
  List<Object?> get props => [email, password];
}
