import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/theme_app.dart';
import 'core/services/navigator_service.dart';
import 'core/dependency_injection/dependency_injection_conf.dart';

import 'features/auth/presenter/views/login/login_view.dart';
import 'features/auth/presenter/cubits/login/login_cubit.dart';
import 'features/auth/domain/usecase/login/login_usecase.dart';
import 'features/auth/domain/usecase/logout/logout_usecase.dart';

import 'features/home/presenter/views/home_view.dart';
import 'features/home/presenter/cubit/home_cubit.dart';

import 'features/splash/presenter/views/splash_view.dart';
import 'features/splash/presenter/cubit/splash_cubit.dart';

class CleanArchApp extends StatefulWidget {
  const CleanArchApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateCleanArchApp();
}

class _StateCleanArchApp extends State<CleanArchApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeApp,
      initialRoute: '/',
      navigatorKey: NavigatorService.navigationKey,
      routes: {
        '/': (_) => BlocProvider(
          create: (BuildContext context) => SplashCubit(),
          child: SplashView()
        ),
        '/home': (_) => BlocProvider(
          create: (BuildContext context) => HomeCubit(
            logoutUsecase: getIt.get<LogoutUsecase>()
          ),
          child: HomeView()
        ),
        '/login': (_) => BlocProvider(
          create: (BuildContext context) => LoginCubit(getIt.get<LoginUsecase>()),
          child: LoginView()
        )
      },
    );
  }
}
