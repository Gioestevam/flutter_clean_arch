import '../../domain/entities/access_token_entity.dart';

class AccessTokenModel extends AccessTokenEntity {
  AccessTokenModel({
    required String accessToken
  }): super(
    accessToken: accessToken
  );

  factory AccessTokenModel.fromJson(Map<String, dynamic> map) {
    return AccessTokenModel(
      accessToken: map['accessToken'] as String,
    );
  }
}
