import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/presentation/controllers/auth_controller.dart';
import '../../core.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthController authController =
      Get.find<AuthController>(tag: AuthController.tag);
  // final appLockController = Get.find<AppLockController>();

  // /// If [pinCodeRequired] is true, the middleware will check if the user has
  // /// enabled the passcode and redirect to the passcode page to unlock to continue
  // ///
  // /// Default is `false`
  // final bool pinCodeRequired;

  // AuthMiddleware({
  //   this.pinCodeRequired = false,
  // });

  @override
  RouteSettings? redirect(String? route) {
    final isAuthenticated = authController.authState.value.isAuthenticated;
    // final isHasPasscode = appLockController.appLockData.value.isPassCodeEnabled;
    final isAuthRoutes = [
      RouteConstants.loginRoute,
    ].contains(route);

    if (!isAuthRoutes && !isAuthenticated) {
      return RouteSettings(name: RouteConstants.authRoute, arguments: {
        RedirectArgumentKeys.redirectRoute: route,
      });
    }
    return null;
  }
}

class RedirectArgumentKeys {
  static String get redirectRoute => 'redirectRoute';
}
