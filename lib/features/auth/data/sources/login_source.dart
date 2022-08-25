import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/utils/constants.dart';

import '../models/access_token_model.dart';

part 'login_source.g.dart';

@RestApi(baseUrl: baseURL)
abstract class LoginSource {
  factory LoginSource(Dio dio, {String baseUrl}) = _LoginSource;

  @POST('/auth/login')
  Future<AccessTokenModel> auth(@Body() LoginParam);
}
