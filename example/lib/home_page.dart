import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_module/core/core.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _MainView(),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserProfileView(),
            // kGapH12,
            // ElevatedButton(
            //   onPressed: () => Get.toNamed(RouteConstants.editProfileRoute),
            //   child: const Text('Chỉnh sửa thông tin'),
            // ),
            // kGapH12,
            // const ElevatedButton(
            //   onPressed: UserModule.logout,
            //   child: Text('Đăng xuất'),
            // ),
          ],
        ),
      ),
    );
  }
}
