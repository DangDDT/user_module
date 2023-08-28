// ignore_for_file: void_checks

import 'package:get/get.dart';
import 'package:user_module/core/core.dart';
import 'package:user_module/src/presentation/pages/edit_profile/edit_profile_controller.dart';
import 'package:user_module/src/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:user_module/src/presentation/pages/login/login_page.dart';

import '../../src/presentation/pages/login/login_controller.dart';
import '../../src/presentation/pages/register/register_controller.dart';
import '../../src/presentation/pages/register/register_page.dart';

class ModuleRouter {
  static final List<GetPage> routes = [
    //  GetPage<dynamic>(
    //   name: route_name,
    //   page: () => const PageName(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut(() => PageNameCtrl());
    //     ...
    //   }),
    // ),

    GetPage(
      name: RouteConstants.loginRoute,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),
    GetPage(
      name: RouteConstants.editProfileRoute,
      page: () => const EditProfilePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => EditProfileController());
      }),
    ),

    GetPage(
      name: RouteConstants.registerRoute,
      page: () => const RegisterPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => RegisterController());
      }),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 210),
    ),
  ];
}
