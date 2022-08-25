import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/params/login_param.dart';

import '../../data/models/access_token_model.dart';

abstract class AuthenticationUseCase {
  Future<Either<Failure, AccessTokenModel>> login(LoginParam param);
  Future<void> reminderPassword();
}
