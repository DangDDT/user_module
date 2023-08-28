import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  ///Controllers
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController fullNameController;
  late final TextEditingController addressController;

  ///States
  late final RegisterState state;

  @override
  void onInit() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    fullNameController = TextEditingController();
    addressController = TextEditingController();
    state = RegisterState();
    super.onInit();
  }

  Future<void> onRegister() async {
    state.onChangeRegisterLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      state.onChangeRegisterLoading(false);
    }
  }
}

class RegisterState {
  final RxBool isShowPassword = false.obs;
  final RxBool isShowConfirmPassword = false.obs;
  final RxBool isRegisterLoading = false.obs;

  void onChangeShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void onChangeShowConfirmPassword() {
    isShowConfirmPassword.value = !isShowConfirmPassword.value;
  }

  void onChangeRegisterLoading(bool value) {
    isRegisterLoading.value = value;
  }
}
