import '../models/access_token_model.dart';
import '../../../../core/params/login_param.dart';

abstract class AuthSource {
  Future<AccessTokenModel> auth(LoginParam param);
  Future<void> logout();
}
