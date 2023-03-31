import 'package:equatable/equatable.dart';

class AccessTokenEntity extends Equatable {
  final String token;
  
  AccessTokenEntity({
    required this.token
  });

  @override
  List<Object?> get props => [token];
}
