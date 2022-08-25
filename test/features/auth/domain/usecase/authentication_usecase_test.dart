import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_arc/core/params/login_param.dart';
import 'package:flutter_clean_arc/features/auth/data/models/access_token_model.dart';
import 'package:flutter_clean_arc/features/auth/domain/usecase/authentication_usecase.dart';
import 'package:flutter_clean_arc/features/auth/domain/usecase/authentication_usercase_impl.dart';
import 'package:flutter_clean_arc/features/auth/domain/repositories/authentication_repository.dart';

class MockAuthenticationRepositoryImpl extends Mock implements AuthenticationRepository {}

void main() {
  late AuthenticationUseCase _usecase;
  late AuthenticationRepository _repository;
  late AccessTokenModel _accessTokenModel;
  late LoginParam _param;

  setUp(() {
    _repository = MockAuthenticationRepositoryImpl();
    _usecase = AuthenticationUseCaseImpl(_repository);

    _accessTokenModel = AccessTokenModel(accessToken: 'token');
    _param = LoginParam(
      email: faker.internet.email(),
      password: faker.internet.password()
    );
  });

  test('Should get Token from the repository', () async {
    when(() => _repository.login(_param))
      .thenAnswer((_) async => right(_accessTokenModel));
      
    final result = await _usecase.login(_param);
    
    expect(result, right(_accessTokenModel));
    verify(() => _repository.login(_param));
  });
}
 