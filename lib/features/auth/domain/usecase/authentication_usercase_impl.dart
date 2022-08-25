import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exception/type_exception.dart';

import '../repositories/authentication_repository.dart';
import 'authentication_usecase.dart';

@LazySingleton(as: AuthenticationUseCase)
class AuthenticationUseCaseImpl implements AuthenticationUseCase {
  AuthenticationUseCaseImpl(this._repository);

  final AuthenticationRepository _repository;

  @override
  Future<Either<TypeException, String>> login({required String email, required String password}) async {
    return await _repository.login(email: email, password: password);
  }

  @override
  Future<void> reminderPassword() {
    // TODO: implement reminderPassword
    throw UnimplementedError();
  }

}
