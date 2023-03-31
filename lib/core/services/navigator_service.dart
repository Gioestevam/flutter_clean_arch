import 'package:flutter/material.dart';

final NavigatorService navigatorService = NavigatorService();

class NavigatorService {
  static final GlobalKey<NavigatorState> navigationKey = new GlobalKey<NavigatorState>();

  Future<dynamic> push(String page, {Object? arguments}) async {
    return navigationKey.currentState!.pushNamed<dynamic>(
      page,
      arguments: arguments,
    );
  }

  Future<dynamic> pushRoute(Route<dynamic> route) async {
    return navigationKey.currentState!.push(route);
  }

  Future<dynamic> pushReplacement(String page, {Object? arguments}) async {
    return navigationKey.currentState!.pushNamedAndRemoveUntil<dynamic>(
      page,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  Future<dynamic> goBack({dynamic result}) async {
    return navigationKey.currentState!.pop<dynamic>(result);
  }

  bool canPop() {
    return navigationKey.currentState!.canPop();
  }

  Future<dynamic> navigateTo(String routeName, Object data) {
    return navigationKey.currentState!.pushNamed(routeName, arguments: data);
  }

  Future<dynamic> navigateToRoot(String routeName, Object? data) {
    return navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: data);
  }

  Future<dynamic> navigatePopAndPush(String routeName) {
    return navigationKey.currentState!.popAndPushNamed(routeName);
  }
}
