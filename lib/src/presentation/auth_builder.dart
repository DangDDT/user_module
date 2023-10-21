import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../domain/models/app_user.dart';
import 'controllers/auth_controller.dart';

///[AuthPageBuilder] provide a better way to build a widget based on the authentication state.
///
///This is used to determine the authentication state of the application.
///
///
///Example:
///```dart
///class HomePage extends AuthPageBuilder {
///   const HomePage({super.key});

///   @override
///   Widget build(BuildContext context) {
///    return Scaffold(
///       appBar: AppBar(title: const Text('HOME')),
///       body: Center(
///         child: Column(
///           mainAxisSize: MainAxisSize.min,
///           children: [
///             authState.when(
///               (state) => Text('Logged in as $state'),
///               onAuthenticated: (user) => Text('Logged in as ${user.fullName}'),
///               onUnAuthenticated: () => const Text('Not logged in'),
///             ),
///             const ElevatedButton(
///               onPressed: UserModule.goAuthSettingPage,
///               child: Text('Auth Setting'),
///             ),
///           ],
///         ),
///       ),
///     );
///  }
/// }
/// ```
abstract class AuthPageBuilder extends StatelessWidget {
  const AuthPageBuilder({super.key});

  ///Application authentication state.
  ///
  ///This is used to determine the authentication state of the application.
  ///
  ///can be used to build a widget based on the authentication state by using [when] method.
  ///
  static AuthController get controller =>
      Get.find<AuthController>(tag: AuthController.tag);
  Rx<AuthState> get authState => controller.authState;
}

extension AuthenticationStateExt on Rx<AuthState> {
  ///Build a widget based on the authentication state.
  ///
  ///- [builder] is the widget to build.
  ///- [onAuthenticated] is the widget to build when the user is authenticated.
  ///- [onUnauthenticated] is the widget to build when the user is unauthenticated.
  ///
  ///If [onAuthenticated] or [onUnauthenticated] is null, the [builder] will be used instead.
  ///otherwise, the [onAuthenticated] or [onUnauthenticated] will be used instead.
  Widget when({
    NotifierBuilder<AuthState>? builder,
    Widget Function(AppUserModel user)? onAuthenticated,
    Widget Function()? onUnauthenticated,
  }) {
    return Obx(() {
      if (value.isAuthenticated) {
        return onAuthenticated != null
            ? onAuthenticated((value as AuthenticatedState).user.user)
            : builder?.call(value) ?? const SizedBox.shrink();
      } else if (value.isUnthenticated) {
        return onUnauthenticated != null
            ? onUnauthenticated()
            : builder?.call(value) ?? const SizedBox.shrink();
      }
      return builder?.call(value) ?? const SizedBox.shrink();
    });
  }
}
