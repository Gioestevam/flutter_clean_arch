import 'package:flutter_clean_arc/features/auth/data/sources/local/auth_storage.dart';
import 'package:flutter_clean_arc/features/auth/domain/usecase/logout/logout_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/authentication_repository.dart';

@LazySingleton(as: LogoutUsecase)
class LogoutUsecaseImpl implements LogoutUsecase {
  LogoutUsecaseImpl(this._repository);

  final AuthenticationRepository _repository;
  @override
  Future<void> signOut() async {
    _repository.logout();

    AuthStorage.clearStorage();
  }
}
