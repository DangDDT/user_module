import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_module/core/utils/helpers/logger.dart';
import 'package:user_module/src/domain/domain.dart';

import '../../../../core/core.dart';
import '../../controllers/auth_controller.dart';
import '../../shared/toast.dart';

class LoginController extends GetxController {
  ///State
  LoginState state = LoginState();

  ///Configs
  ModuleConfig get _moduleConfig =>
      Get.find<ModuleConfig>(tag: ModuleConfig.tag);

  final AuthController _authController =
      Get.find<AuthController>(tag: AuthController.tag);

  ///Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> onLogin() async {
    state.onChangeLoginLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 2));

      ///TODO: Call api login
      final user = await callLoginApi();
      if (user == null) {
        throw ValidationException(
          ValidationExceptionKind.invalidOutput,
        );
      }
      await _authController.login(user);
      await _onLoginSuccess();
      await Future.delayed(const Duration(seconds: 1));
    } catch (e, stackTrace) {
      Logger.log(
        e.toString(),
        name: 'LoginController - onLogin',
        stackTrace: stackTrace,
      );
      Toast.showError(
        title: 'Đăng nhập thất bại',
        message: 'Đã có lỗi xảy ra, vui lòng thử lại!',
      );
    } finally {
      state.onChangeLoginLoading(false);
    }
  }

  Future<AuthenticatedUser?> callLoginApi() async {
    ///TODO: Call api login
    return AuthenticatedUser.mock();
  }

  Future<void> _onLoginSuccess() async {
    if (_authController.authState.value.isAuthenticated) {
      Get.offNamed(_moduleConfig.homeRoute);
    } else {
      Get.offAllNamed(RouteConstants.loginRoute);
    }
  }

  void onRegister() {
    Get.toNamed(RouteConstants.registerRoute);
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
