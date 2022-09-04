import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arc/core/services/navigator_service.dart';
import 'package:flutter_clean_arc/features/auth/domain/usecase/logout/logout_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit({
    required this.logoutUsecase
  }) : super(Initial());
  
  final LogoutUsecase logoutUsecase;
  
  void logout() {
    logoutUsecase.signOut();

    navigatorService.navigateToRoot('/login', null);
  }

}
