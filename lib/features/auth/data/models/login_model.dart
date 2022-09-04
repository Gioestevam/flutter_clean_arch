
import '../../domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel.mapper(Map<String, dynamic> data) : super(
    email: data['email'] as String,
    password: data['password'] as String,
  );
}
