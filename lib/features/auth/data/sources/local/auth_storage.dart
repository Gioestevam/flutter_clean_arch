import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static final _storage = FlutterSecureStorage();

  static final _keyToken = 'token';

  static Future setToken(String token) async =>
    await _storage.write(key: _keyToken, value: token);

  static Future<String?> getToken() async => 
    await _storage.read(key: _keyToken);

  static Future<void> clearStorage() async => await _storage.deleteAll();
}
