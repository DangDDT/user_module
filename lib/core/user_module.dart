library vay_von_package;

import 'package:get/get.dart';
import 'package:user_module/core/typedefs/auth_listener.dart';

import '../src/infrastructure/local_databases/isar/isar_database.dart';
import '../src/presentation/controllers/auth_controller.dart';
import 'core.dart';

export '../src/presentation/widgets/auth_view_builder_wrapper.dart';
export '../src/presentation/auth_builder.dart';
export '../src/domain/models/app_user.dart';
export '../core/routes/middlewares/auth_middleware.dart';
export '../src/presentation/views/public_view.dart';

class UserModule {
  static const packageName = "user_module-$version";
  static const version = "1.0.0";
  static List<GetPage<dynamic>> get pageRoutes => ModuleRouter.routes;
  static TranslateManager get l10n => TranslateManager();

  static bool _isInitialized = false;

  ///The current logged in user's access token. If there is no user logged in, this will return `null`.
  static Future<String?> get getAccessToken async =>
      Get.find<AuthController>(tag: AuthController.tag).accessToken;

  ///The current logged in [AppUser]. If there is no user logged in, this will return `null`.
  ///
  ///In case you want to access user data to build UI, you should use [AuthViewBuilder] instead
  ///to achieve auto rebuild UI when the authentication state changes.
  static AppUser? get currentUser =>
      Get.find<AuthController>(tag: AuthController.tag).currentUser.value?.user;

  static Future<void> init({
    bool isShowLog = false,
    required BaseUrlConfig baseUrlConfig,
    LoginViewConfig? viewConfig,
    required String homeRoute,
    required Future<AuthenticatedUser?> Function(
      String refreshToken,
      String accessToken,
    )? onRefreshTokenApiCallback,
    MockConfig? mockConfig,
  }) async {
    await IsarDatabase.init();
    await GlobalBinding.setUpLocator(
      isShowLog: isShowLog,
      baseUrlConfig: baseUrlConfig,
      viewConfig: viewConfig,
      homeRoute: homeRoute,
      onRefreshTokenApiCallback: onRefreshTokenApiCallback,
      mockConfig: mockConfig,
    );
    _isInitialized = true;
  }

  static void _assertInitialized() {
    if (!_isInitialized) {
      throw AssertionError(
        'UserModule is not initialized. Please call UserModule.init() before using any methods of UserModule.',
      );
    }
  }

  static Future<void> logout() async {
    _assertInitialized();
    await Get.find<AuthController>(tag: AuthController.tag).logout();
  }

  static void addAuthStateListener(AuthListener listener) {
    _assertInitialized();
    Get.find<AuthController>(tag: AuthController.tag)
        .addAuthStateListener(listener);
  }

  static Future<void> removeAuthStateListener(AuthListener listener) async {
    _assertInitialized();
    Get.find<AuthController>(tag: AuthController.tag)
        .removeAuthStateListener(listener);
  }

  static Future<void> toEditProfilePage() async {
    _assertInitialized();
    await Get.toNamed(RouteConstants.editProfileRoute);
  }
}
