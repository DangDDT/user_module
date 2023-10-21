import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_module/src/presentation/auth_builder.dart';
import 'package:user_module/src/presentation/controllers/auth_controller.dart';

import '../../domain/models/app_user.dart';

class AuthViewBuilderWrapper extends AuthPageBuilder {
  const AuthViewBuilderWrapper({
    super.key,
    this.builder,
    this.onAuthenticated,
    this.onUnAuthenticated,
  });

  /// The [builder] will be called when the [authState] changes.
  final NotifierBuilder<AuthState>? builder;

  ///[onAuthenticated] is the widget builder to build when the user is authenticated.
  ///
  ///If [onAuthenticated] is null, the [builder] will be used instead.
  /// otherwise, the [onAuthenticated] will be used.
  final Widget Function(AppUserModel user)? onAuthenticated;

  ///[onUnAuthenticated] is the widget builder to build when the user is unauthenticated.
  ///
  ///If [onUnAuthenticated] is null, the [builder] will be used instead.
  /// otherwise, the [onUnAuthenticated] will be used.
  final Widget Function()? onUnAuthenticated;

  @override
  Widget build(BuildContext context) {
    return authState.when(
      builder: builder,
      onAuthenticated: onAuthenticated,
      onUnauthenticated: onUnAuthenticated,
    );
  }
}
