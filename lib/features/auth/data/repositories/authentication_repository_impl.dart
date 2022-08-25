import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/params/login_param.dart';
import '../../../../core/exception/type_exception.dart';

import '../sources/login_source.dart';

import '../../domain/repositories/authentication_repository.dart';

@LazySingleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final LoginSource _loginSource;
  AuthenticationRepositoryImpl(this._loginSource);

  @override
  Future<Either<TypeException, String>> login({required String email,required  String password}) async {
    try {
      final LoginParam param = LoginParam(email: email, password: password);
      final response = await _loginSource.auth(param);

      return right(response.accessToken); 
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return left(TypeException.unauthorized);
      }

      return left(TypeException.validation);
    }
  }

  @override
  Future<Either<TypeException, String>> passwordReminder(String email) {
    // TODO: implement passwordReminder
    throw UnimplementedError();
  }
}
