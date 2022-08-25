import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arc/core/exception/type_exception.dart';

abstract class AuthenticationRepository {
  Future<Either<TypeException, String>> login({required String email,required  String password});
  Future<Either<TypeException, String>> passwordReminder(String email);
}
