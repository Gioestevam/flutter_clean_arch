import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/params/login_param.dart';

import '../../data/models/access_token_model.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AccessTokenModel>> login(LoginParam param);
  Future<Either<Failure, String>> passwordReminder(String email);
}
