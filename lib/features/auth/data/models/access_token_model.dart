import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/access_token_entity.dart';

part 'access_token_model.g.dart';

@JsonSerializable()
class AccessTokenModel extends AccessTokenEntity {
  AccessTokenModel({
    required String token
  }): super(
    token: token
  );

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) => _$AccessTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenModelToJson(this);
}
