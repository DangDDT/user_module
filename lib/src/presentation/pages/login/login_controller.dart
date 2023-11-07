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
      final user = await callLoginApi();
      if (user == null) {
        return;
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
    } finally {
      state.onChangeLoginLoading(false);
    }
  }

  Future<AuthenticatedUser?> callLoginApi() async {
    try {
      if (usernameController.text.isEmpty) {
        Toast.showInfo(
          message: 'Vui lòng nhập tên đăng nhập',
        );
        throw ValidationException(
          ValidationExceptionKind.invalidInput,
          message: 'Vui lòng nhập tên đăng nhập',
        );
      }
      if (!usernameController.text.isEmail) {
        Toast.showInfo(
          message: 'Vui lòng nhập đúng định dạng email',
        );
        throw ValidationException(
          ValidationExceptionKind.invalidInput,
          message: 'Vui lòng nhập đúng định dạng email',
        );
      }
      if (passwordController.text.isEmpty) {
        Toast.showInfo(
          message: 'Vui lòng nhập mật khẩu',
        );
        throw ValidationException(
          ValidationExceptionKind.invalidInput,
          message: 'Vui lòng nhập mật khẩu',
        );
      }
      final token = await _moduleConfig.onGetFirebaseToken?.call(
        usernameController.text,
        passwordController.text,
      );
      if (token == null) {
        Toast.showError(
          title: 'Không tìm thấy tài khoản của bạn trong hệ thống',
          message: 'Vui lòng liên hệ với cửa hàng để được hỗ trợ',
        );
        throw ValidationException(
          ValidationExceptionKind.invalidOutput,
          message: 'Không tìm thấy tài khoản của người dùng trong hệ thống',
          advice: 'Vui lòng liên hệ với quản trị viên để được hỗ trợ',
        );
      }
      final user = await _authController.getUser(token: token);
      if (user == null) {
        Toast.showError(
          title: 'Không tìm thấy tài khoản của bạn trong hệ thống',
          message: 'Vui lòng liên hệ với cửa hàng để được hỗ trợ',
        );
        throw ValidationException(
          ValidationExceptionKind.invalidOutput,
          message: 'Không tìm thấy tài khoản của người dùng trong hệ thống',
          advice: 'Vui lòng liên hệ với quản trị viên để được hỗ trợ',
        );
      }
      return user;
    } catch (_) {}
    return null;
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
