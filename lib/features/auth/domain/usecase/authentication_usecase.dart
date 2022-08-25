import 'package:dartz/dartz.dart';

import '../../../../core/exception/type_exception.dart';

abstract class AuthenticationUseCase {
  Future<Either<TypeException, String>> login({required String email,required  String password});
  Future<void> reminderPassword();
}
