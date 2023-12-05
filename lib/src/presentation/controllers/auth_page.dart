import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_module/src/presentation/controllers/auth_controller.dart';
import 'package:user_module/src/presentation/shared/loading_widget.dart';

class UserAuthPage extends GetView<AuthController> {
  const UserAuthPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final views = <AuthView, Widget>{
    //   AuthView.login: const NewLoginCard(),
    //   // AuthView.recentLogged: const RecentLoggedCard(),
    //   AuthView.loginWithSavedAccount: const ReLoginCard(),
    //   AuthView.confirmPhoneOTP: const ConfirmOTPCard()
    // };
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            LoadingWidget(
              message: 'Đang đăng nhập',
            ),
          ],
        ),
      ),
    );
    //   return Obx(() {
    //     final isNotRecentLoggedView =
    //         controller.authView.value != AuthView.recentLogged;
    //     return GetBuilder<RecentLoggedController>(
    //       builder: (recentLoggedController) {
    //         final isHaveRecentLoggedUsers =
    //             recentLoggedController.recentUsers.isNotEmpty;
    //         return Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             AnimatedSize(
    //               clipBehavior: Clip.none,
    //               duration: const Duration(milliseconds: 210),
    //               child: AnimatedSwitcher(
    //                 duration: const Duration(milliseconds: 410),
    //                 switchInCurve: Curves.linearToEaseOut,
    //                 transitionBuilder: (child, animation) => SlideTransition(
    //                   position: Tween<Offset>(
    //                     begin: const Offset(2, 0),
    //                     end: Offset.zero,
    //                   ).animate(animation),
    //                   child: FadeTransition(
    //                     opacity: animation,
    //                     child: child,
    //                   ),
    //                 ),
    //                 child: views[controller.authView.value],
    //               ),
    //             ),
    //             if (isHaveRecentLoggedUsers && isNotRecentLoggedView)
    //               VIFFlatButton(
    //                 fadedStyle: true,
    //                 fadedOpacity: .27,
    //                 color: Get.theme.colorScheme.onPrimary,
    //                 minWidth: 0,
    //                 onPressed: () =>
    //                     controller.setAuthView(AuthView.recentLogged),
    //                 leading: const Icon(Icons.chevron_left),
    //                 label: 'Đăng nhập gần đây',
    //               ),
    //           ],
    //         );
    //       },
    //     );
    //   });
    // }
  }
}
