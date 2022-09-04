import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:flutter_clean_arc/core/error/failures.dart';
import 'package:flutter_clean_arc/core/params/login_param.dart';
import 'package:flutter_clean_arc/features/auth/data/sources/auth_client.dart';
import 'package:flutter_clean_arc/features/auth/data/sources/auth_source.dart';
import 'package:flutter_clean_arc/features/auth/data/models/access_token_model.dart';
import 'package:flutter_clean_arc/features/auth/data/sources/remote/remote_source_impl.dart';

class MockDioAdapter extends Mock implements DioAdapter {}

void main() {
  final dio = Dio();
  late AuthClient _authClient;
  late AuthSource _source;
  late MockDioAdapter _mockDioAdapter;
  late LoginParam _param;

  final mapJson = '''{
    "token": "any_token"
  }''';

  final accessTokenModel = AccessTokenModel.fromJson(json.decode(mapJson));

  setUp(() {
    _authClient = AuthClient(dio);
    _mockDioAdapter = MockDioAdapter();
    dio.httpClientAdapter = _mockDioAdapter;

    _source = RemoteSourceImpl(_authClient);
    _param = LoginParam(
      email: faker.internet.email(),
      password: faker.internet.password()
    );

    registerFallbackValue(RequestOptions(path: '/auth/login'));
  });

  void mockDioResponseSuccessfully() {
    when(() => _mockDioAdapter.fetch(any(), any(), any()))
      .thenAnswer((_) async => ResponseBody.fromString(
          mapJson,
          200,
          headers: {Headers.contentTypeHeader: [Headers.jsonContentType],}
        )
      );
  }

  void mockDioResponseFailure() {
    when(() => _mockDioAdapter.fetch(any(), any(), any()))
      .thenAnswer((_) async => ResponseBody.fromString(
          '',
          500,
          headers: {Headers.contentTypeHeader: [Headers.jsonContentType],}
        )
      );
  }

  test('Should return AccessToken when the response code is 200', () async {
    mockDioResponseSuccessfully();

    final result = await _source.auth(_param);

    expect(result, equals(accessTokenModel));
  });

  test('Should throw a ServerException when the response code is 500 or other', () async {
    mockDioResponseFailure();

    final call = () async => await _source.auth(_param);
    
    expect(call(), throwsA(TypeMatcher<ServerFailure>()));
  });
}
