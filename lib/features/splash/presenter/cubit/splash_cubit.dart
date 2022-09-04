import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arc/core/services/navigator_service.dart';
import 'package:flutter_clean_arc/features/auth/data/sources/local/auth_storage.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(): super(Initial()) {
    _init();
  }

  void _init() async {
    Future.delayed(Duration(seconds: 2), () async {
      String? token = await AuthStorage.getToken();

      if (token != null) {
        return navigatorService.navigateToRoot('/home', null);
      }

      return navigatorService.navigateToRoot('/login', null);
    });
  }
}
