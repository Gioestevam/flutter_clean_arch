import 'package:flutter_clean_arc/core/services/navigator_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import './dependency_injection_conf.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void configureDependencies() {

  getIt.registerLazySingleton(() => NavigatorService());
  $initGetIt(getIt);
}
