library vay_von_package;

import 'package:get/get.dart';

import 'core.dart';

class UserModule {
  static const packageName = "user_module-$version";
  static const version = "1.0.0";
  static List<GetPage<dynamic>> get pageRoutes => ModuleRouter.routes;
  static TranslateManager get l10n => TranslateManager();

  static Future<void> init({
    bool isShowLog = false,
    required BaseUrlConfig baseUrlConfig,
    ViewConfig? viewConfig,
  }) async {
    GlobalBinding.setUpLocator(
      isShowLog: isShowLog,
      baseUrlConfig: baseUrlConfig,
      viewConfig: viewConfig,
    );
  }

  static Future<void> login({
    required UserConfig userConfig,
    AuthConfig? authConfig,
  }) async {
    final ModuleConfig moduleConfig = Get.find<ModuleConfig>(tag: packageName);
    moduleConfig.setUserConfig = userConfig;
    moduleConfig.setAuthConfig = authConfig;
  }

  static Future<void> logout() async {
    final ModuleConfig moduleConfig = Get.find<ModuleConfig>(tag: packageName);
    moduleConfig.setUserConfig = null;
    moduleConfig.setAuthConfig = null;
  }
}
