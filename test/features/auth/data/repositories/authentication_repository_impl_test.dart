import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_arc/core/error/failures.dart';
import 'package:flutter_clean_arc/core/params/login_param.dart';

import 'package:flutter_clean_arc/features/auth/data/sources/auth_source.dart';
import 'package:flutter_clean_arc/features/auth/data/models/access_token_model.dart';
import 'package:flutter_clean_arc/features/auth/data/repositories/authentication_repository_impl.dart';

import 'package:flutter_clean_arc/features/auth/domain/repositories/authentication_repository.dart';

class MockRemoteSource extends Mock implements AuthSource {}

void main() {
  final accessTokenModel = AccessTokenModel(token: 'token');

  late AuthenticationRepository _repository;  
  late MockRemoteSource _sourceMock;
  late LoginParam _param;

  setUp(() {
    _sourceMock = MockRemoteSource();
    _repository = AuthenticationRepositoryImpl(_sourceMock);
    _param = LoginParam(
      email: faker.internet.email(),
      password: faker.internet.password()
    );

    registerFallbackValue(_param);
  });

  test('Should return data when the call to login source is successfully', () async {
    when(() => _sourceMock.auth(any()))
      .thenAnswer((_) async => accessTokenModel);

    var result = await _repository.login(_param);
    
    verify(() => _sourceMock.auth(_param));
    
    expect(result, equals(Right(accessTokenModel)));
  });

  test('Should return UnauthorizedFailure when the call to login source if return 401', () async {
    when(() => _sourceMock.auth(any()))
      .thenThrow(DioError(
          requestOptions: RequestOptions(path: '/auth/login'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/auth/login'),
          ),
        )
      );

    var result = await _repository.login(_param);

    verify(() => _sourceMock.auth(_param));
    expect(result, equals(Left(UnauthorizedFailure())));
  });

  test('Should return ServerFailure when the call to login source if return 500', () async {
    when(() => _sourceMock.auth(any()))
      .thenThrow(DioError(
          requestOptions: RequestOptions(path: '/auth/login'),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: '/auth/login'),
          ),
        )
      );

    var result = await _repository.login(_param);

    verify(() => _sourceMock.auth(_param));
    expect(result, equals(Left(ServerFailure())));
  });
}
