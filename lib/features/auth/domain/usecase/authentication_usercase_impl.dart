import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/params/login_param.dart';
import '../../data/models/access_token_model.dart';
import '../repositories/authentication_repository.dart';

import 'authentication_usecase.dart';

@LazySingleton(as: AuthenticationUseCase)
class AuthenticationUseCaseImpl implements AuthenticationUseCase {
  AuthenticationUseCaseImpl(this._repository);

  final AuthenticationRepository _repository;

  @override
  Future<Either<Failure, AccessTokenModel>> login(LoginParam param) async {
    return await _repository.login(param);
  }

  @override
  Future<void> reminderPassword() {
    // TODO: implement reminderPassword
    throw UnimplementedError();
  }

}
