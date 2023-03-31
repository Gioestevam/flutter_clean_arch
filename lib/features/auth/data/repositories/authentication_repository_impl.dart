import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/params/login_param.dart';

import '../models/access_token_model.dart';

import '../../domain/repositories/authentication_repository.dart';
import '../sources/auth_source.dart';

@LazySingleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthSource _source;
  AuthenticationRepositoryImpl(this._source);

  @override
  Future<Either<Failure, AccessTokenModel>> login(LoginParam param) async {
    try {
      final response = await _source.auth(param);

      return Right(response);
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          return left(UnauthorizedFailure());
        }

        return left(ServerFailure());
      } else if (e is Failure) {
        return left(e);
      }

      return left(ServerFailure());
    }
  }

  @override
  Future<void> logout() async => await _source.logout();

  @override
  Future<Either<Failure, String>> passwordReminder(String email) {
    // TODO: implement passwordReminder
    throw UnimplementedError();
  }
  
}
