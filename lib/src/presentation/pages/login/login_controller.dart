import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/core.dart';

class LoginController extends GetxController {
  ///State
  LoginState state = LoginState();

  Future<void> onLogin() async {
    state.onChangeLoginLoading(true);
    try {
      ///TODO: Call API login
      await Future.delayed(const Duration(seconds: 2));
      state.onChangeLoginLoading(false);
    } catch (e, stackTrace) {
      Logger.log(
        e.toString(),
        name: 'LoginController - onLogin',
        stackTrace: stackTrace,
      );
      Get.snackbar(
        'Lỗi đăng nhập',
        'Đang có sự cố xảy ra, vui lòng thử lại!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      state.onChangeLoginLoading(false);
    }
  }
}

class LoginState {
  final RxBool isShowPassword = false.obs;
  final RxBool isLoginLoading = false.obs;

  void onChangeShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void onChangeLoginLoading(bool value) {
    isLoginLoading.value = value;
  }
}
