import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/params/login_param.dart';

import '../models/access_token_model.dart';

import '../../domain/repositories/authentication_repository.dart';
import '../sources/remote_source.dart';

@LazySingleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final RemoteSource _source;
  AuthenticationRepositoryImpl(this._source);

  @override
  Future<Either<Failure, AccessTokenModel>> login(LoginParam param) async {
    try {
      final response = await _source.auth(param);

      return right(response); 
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return left(UnauthorizedFailure());
      }

      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> passwordReminder(String email) {
    // TODO: implement passwordReminder
    throw UnimplementedError();
  }
}
