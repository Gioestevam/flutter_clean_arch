import 'package:dio/dio.dart';
import 'package:flutter_clean_arc/core/error/failures.dart';
import 'package:flutter_clean_arc/features/auth/data/models/access_token_model.dart';

import 'package:flutter_clean_arc/core/params/login_param.dart';
import 'package:flutter_clean_arc/features/auth/data/sources/auth_client.dart';
import 'package:injectable/injectable.dart';

import 'remote_source.dart';

@LazySingleton(as: RemoteSource)
class RemoteSourceImpl implements RemoteSource {
RemoteSourceImpl(this._client);

  final AuthClient _client;
  
  @override
  Future<AccessTokenModel> auth(LoginParam param) async {
    try {
      var result = await _client.auth(param);

      return result;
    } on DioError catch(e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedFailure();
      }
      
      throw ServerFailure();
    }
  }
  
}
