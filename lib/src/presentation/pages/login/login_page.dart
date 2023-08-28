import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:user_module/src/presentation/shared/shared.dart';
import 'package:user_module/src/presentation/widgets/custom_text_field.dart';

import '../../../../core/core.dart';
import '../../widgets/background_image_wrapper.dart';
import '../../widgets/loading_button.dart';
import '../../widgets/logo_and_app_name_wrapper.dart';
import '../../widgets/responsive_width.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({
    super.key,
  });

  static final ModuleConfig _moduleConfig =
      Get.find<ModuleConfig>(tag: ModuleConfig.tag);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: ImageBackgroundWrapper(
          child: _MainView(
            logo: _moduleConfig.loginViewConfig?.logo,
            appName:
                _moduleConfig.loginViewConfig?.appName ?? 'Blissfull Bells',
          ),
        ),
      ),
    );
  }
}

class _MainView extends StatelessWidget {
  final Widget? logo;
  final String appName;
  const _MainView({this.logo, required this.appName});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.black12,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.15),
              child: const LogoAndAppNameWrapper(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FadeSlideTransition(
                      duration: Duration(milliseconds: 410),
                      child: _LoginForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends GetView<LoginController> {
  const _LoginForm();

  static final ModuleConfig _moduleConfig =
      Get.find<ModuleConfig>(tag: ModuleConfig.tag);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: ResponsiveWidthWrapper(
          child: Column(
            children: [
              Text(
                'Đăng nhập',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: kTheme.colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              kGapH12,
              Text(
                'Điền tên đăng nhập và mật khẩu của bạn để đăng nhập',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: kTheme.colorScheme.onBackground,
                    ),
              ),
              kGapH24,
              const _UsernameTextField(),
              kGapH12,
              const _PasswordTextField(),
              kGapH24,
              const _LoginButton(),
              kGapH12,
              if ((_moduleConfig.loginViewConfig?.isShowRegisterButton ??
                      true) ||
                  (_moduleConfig.loginViewConfig?.isShowForgotPasswordButton ??
                      true))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_moduleConfig
                            .loginViewConfig?.isShowForgotPasswordButton ??
                        true)
                      const _ForgotPasswordButton()
                    else
                      const SizedBox(),
                    if (_moduleConfig.loginViewConfig?.isShowRegisterButton ??
                        true)
                      const _RegisterButton()
                    else
                      const SizedBox(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterButton extends GetView<LoginController> {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: controller.onRegister,
      child: Text(
        'Đăng ký tài khoản',
        style: kTheme.textTheme.bodyLarge?.copyWith(
          color: kTheme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          shadows: [
            const Shadow(
              color: Colors.white,
              blurRadius: 40,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {},
      child: Text(
        'Quên mật khẩu ?',
        style: kTheme.textTheme.bodyLarge?.copyWith(
          color: kTheme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          shadows: [
            const Shadow(
              color: Colors.white,
              blurRadius: 40,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends GetView<LoginController> {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap:
            controller.state.isLoginLoading.value ? null : controller.onLogin,
        child: LoadingButton(
          isLoading: controller.state.isLoginLoading.value,
          label: 'Đăng nhập',
        ),
      ),
    );
  }
}

class _UsernameTextField extends GetView<LoginController> {
  const _UsernameTextField();

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: 'Tên đăng nhập',
      isShowHintText: true,
      textInputAction: TextInputAction.next,
      controller: controller.usernameController,
    );
  }
}

class _PasswordTextField extends GetView<LoginController> {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTextField(
        controller: controller.passwordController,
        labelText: 'Mật khẩu',
        isShowHintText: true,
        obscureText: !controller.state.isShowPassword.value,
        textInputAction: TextInputAction.done,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: controller.state.onChangeShowPassword,
            icon: controller.state.isShowPassword.value
                ? const Icon(FontAwesomeIcons.eyeSlash)
                : const Icon(FontAwesomeIcons.eye),
          ),
        ),
        onSubmitted: (_) => controller.onLogin(),
      ),
    );
  }
}
