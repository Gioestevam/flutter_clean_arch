import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arc/features/auth/data/sources/local/auth_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/params/login_param.dart';

import '../../../data/models/access_token_model.dart';

import '../../repositories/authentication_repository.dart';

import 'login_usecase.dart';

@LazySingleton(as: LoginUsecase)
class LoginUsecaseImpl implements LoginUsecase {
  LoginUsecaseImpl(this._repository);

  final AuthenticationRepository _repository;
  @override
  Future<Either<Failure, AccessTokenModel>> login(LoginParam param) async {
    var response = await _repository.login(param);

    return response.fold(
      (l) => left(l),
      (r) async {
        await AuthStorage.setToken(r.token);

        return right(r);
      }
    );
  }
}
