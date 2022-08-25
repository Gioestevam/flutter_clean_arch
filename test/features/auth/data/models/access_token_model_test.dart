import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_arc/features/auth/data/models/access_token_model.dart';
import 'package:flutter_clean_arc/features/auth/domain/entities/access_token_entity.dart';

void main() {
  final accessTokenModel = AccessTokenModel(accessToken: 'token');
  test('Should be a subclass of AccessTokenEntity', () async {
    expect(accessTokenModel, isA<AccessTokenEntity>());
  });

  test('Should return a valid model when the JSON token is an String', () async {
    final Map<String, dynamic> map = json.decode(
      '''{
        "access_token": "token"
      }'''
    );
    
    final result = AccessTokenModel.fromJson(map);
    
    expect(result, accessTokenModel);
  });

  test('Should return a JSON map containing the proper data', () async {
    final expectedMap = {
      "access_token": "token"
    };
    
    final result = accessTokenModel.toJson();

    expect(result, expectedMap);
  });
}
