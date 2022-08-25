import '../../../../core/params/login_param.dart';

import '../models/access_token_model.dart';

abstract class RemoteSource {
  Future<AccessTokenModel> auth(LoginParam param);
}
