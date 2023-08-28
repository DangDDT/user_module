import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:user_module/src/presentation/shared/shared.dart';
import 'package:user_module/src/presentation/widgets/background_image_wrapper.dart';
import 'package:user_module/src/presentation/widgets/custom_text_field.dart';
import 'package:user_module/src/presentation/widgets/loading_button.dart';
import 'package:user_module/src/presentation/widgets/logo_and_app_name_wrapper.dart';
import 'package:user_module/src/presentation/widgets/responsive_width.dart';

import '../../../../core/core.dart';
import '../../../../core/utils/formatters/phone_number_formatter.dart';
import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: ImageBackgroundWrapper(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: ResponsiveWidthWrapper(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: const LogoAndAppNameWrapper(
                    children: [
                      FadeSlideTransition(
                        duration: Duration(milliseconds: 410),
                        child: _RegisterForm(),
                      ),
                      FadeSlideTransition(
                        duration: Duration(milliseconds: 610),
                        child: _BackToLoginButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          children: [
            Text(
              'Đăng ký tài khoản',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: kTheme.colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            kGapH12,
            Text(
              'Điền thông tin của bạn để đăng ký tài khoản',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: kTheme.colorScheme.onBackground,
                  ),
            ),
            kGapH12,
            const _RegisterUsername(),
            kGapH12,
            const _RegisterPassword(),
            kGapH12,
            const _RegisterConfirmPassword(),
            kGapH12,
            const _RegisterEmail(),
            kGapH12,
            const _RegisterPhoneNumber(),
            kGapH24,
            const _RegisterButton(),
          ],
        ),
      ),
    );
  }
}

class _RegisterUsername extends GetView<RegisterController> {
  const _RegisterUsername();

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Nhập tên đăng nhập (*)',
      controller: controller.usernameController,
    );
  }
}

class _RegisterPassword extends GetView<RegisterController> {
  const _RegisterPassword();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTextField(
        controller: controller.passwordController,
        labelText: 'Nhập mật khẩu (*)',
        isShowHintText: true,
        obscureText: !controller.state.isShowPassword.value,
        textInputAction: TextInputAction.next,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: controller.state.onChangeShowPassword,
            icon: controller.state.isShowPassword.value
                ? const Icon(FontAwesomeIcons.eyeSlash)
                : const Icon(FontAwesomeIcons.eye),
          ),
        ),
      ),
    );
  }
}

class _RegisterConfirmPassword extends GetView<RegisterController> {
  const _RegisterConfirmPassword();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTextField(
        controller: controller.confirmPasswordController,
        labelText: 'Nhập lại mật khẩu (*)',
        isShowHintText: true,
        obscureText: !controller.state.isShowConfirmPassword.value,
        textInputAction: TextInputAction.next,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: controller.state.onChangeShowConfirmPassword,
            icon: controller.state.isShowConfirmPassword.value
                ? const Icon(FontAwesomeIcons.eyeSlash)
                : const Icon(FontAwesomeIcons.eye),
          ),
        ),
      ),
    );
  }
}

class _RegisterEmail extends GetView<RegisterController> {
  const _RegisterEmail();

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Nhập email (*)',
      controller: controller.emailController,
    );
  }
}

class _RegisterPhoneNumber extends GetView<RegisterController> {
  const _RegisterPhoneNumber();

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Nhập số điện thoại (*)',
      keyboardType: TextInputType.phone,
      inputFormatters: [
        PhoneNumberFormatter(),
      ],
      controller: controller.phoneController,
    );
  }
}

class _RegisterButton extends GetView<RegisterController> {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.onRegister,
      child: Obx(
        () => LoadingButton(
          label: 'Đăng ký tài khoản',
          isLoading: controller.state.isRegisterLoading.value,
        ),
      ),
    );
  }
}

class _BackToLoginButton extends StatelessWidget {
  const _BackToLoginButton();

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: kTheme.colorScheme.onBackground,
      ),
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 16,
      ),
      onPressed: () => Get.back(),
      label: Text(
        'Quay lại đăng nhập',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: kTheme.colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
