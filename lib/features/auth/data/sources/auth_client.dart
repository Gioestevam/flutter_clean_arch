import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/utils/constants.dart';

import '../models/access_token_model.dart';

part 'auth_client.g.dart';

@RestApi(baseUrl: baseURL)
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @POST('/auth/login')
  Future<AccessTokenModel> auth(@Body() LoginParam);
}
