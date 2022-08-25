import 'package:equatable/equatable.dart';

class AccessTokenEntity extends Equatable {
  String accessToken;
  
  AccessTokenEntity({
    required this.accessToken
  });

  @override
  List<Object?> get props => [accessToken];
}
