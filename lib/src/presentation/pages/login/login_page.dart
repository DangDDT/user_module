import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:user_module/src/presentation/shared/shared.dart';
import 'package:user_module/src/presentation/widgets/custom_text_field.dart';

import '../../../../core/core.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  static final ModuleConfig _moduleConfig =
      Get.find<ModuleConfig>(tag: ModuleConfig.tag);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (_) => KeyboardDismisser(
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: _BackgroundImage(
                  imageBackground: _moduleConfig.viewConfig?.imageBackground,
                ),
              ),
              Positioned(
                child: _MainView(
                  logo: _moduleConfig.viewConfig?.logo,
                  appName: _moduleConfig.viewConfig?.appName ?? 'Wedy Store',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  final String? imageBackground;
  const _BackgroundImage({this.imageBackground});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageBackground ?? Assets.user_module$assets_images_login_background_png,
      fit: BoxFit.cover,
    );
  }
}

class _MainView extends StatelessWidget {
  final Widget? logo;
  final String appName;
  const _MainView({this.logo, required this.appName});

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.2),
              child: FadeSlideTransition(
                duration: const Duration(milliseconds: 610),
                child: Column(
                  children: [
                    _Logo(logo: logo),
                    kGapH12,
                    _AppName(appName: appName),
                    kGapH12,
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final Widget? logo;
  const _Logo({this.logo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.height * 0.2,
      height: Get.height * 0.2,
      child: logo ?? const Placeholder(),
    );
  }
}

class _AppName extends StatelessWidget {
  final String appName;
  const _AppName({required this.appName});

  @override
  Widget build(BuildContext context) {
    return Text(
      appName,
      style: kTheme.textTheme.displayLarge?.copyWith(
        color: kTheme.colorScheme.primary,
        fontFamily: GoogleFonts.dancingScript().fontFamily,
        fontWeight: FontWeight.bold,
        wordSpacing: 2,
        letterSpacing: 2,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 2,
            offset: const Offset(4, 4),
          ),
          const Shadow(
            color: Colors.white,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
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
    return Column(
      children: [
        const _LoginTextField(),
        kGapH12,
        const _PasswordTextField(),
        kGapH24,
        const _LoginButton(),
        kGapH12,
        if ((_moduleConfig.viewConfig?.isShowRegisterButton ?? true) ||
            (_moduleConfig.viewConfig?.isShowForgotPasswordButton ?? true))
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_moduleConfig.viewConfig?.isShowForgotPasswordButton ?? true)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: _ForgotPasswordButton(),
                ),
              if (_moduleConfig.viewConfig?.isShowRegisterButton ?? true)
                const Align(
                  alignment: Alignment.centerRight,
                  child: _RegisterButton(),
                ),
            ],
          ),
      ],
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {},
      child: Text(
        'Đăng ký tài khoản',
        style: kTheme.textTheme.bodyLarge?.copyWith(
          color: kTheme.colorScheme.onPrimary,
          fontWeight: FontWeight.w500,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(2, 2),
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
          color: kTheme.colorScheme.onPrimary,
          fontWeight: FontWeight.w500,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(2, 2),
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 410),
          curve: Curves.decelerate,
          width: controller.state.isLoginLoading.value
              ? Get.width * 0.15
              : Get.width,
          height: 48,
          decoration: BoxDecoration(
            color: kTheme.colorScheme.primary,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: controller.state.isLoginLoading.value
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: kTheme.colorScheme.onPrimary,
                    ),
                  )
                : Text(
                    'Đăng nhập',
                    style: kTheme.textTheme.titleMedium?.copyWith(
                      color: kTheme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _LoginTextField extends StatelessWidget {
  const _LoginTextField();

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(
      labelText: 'Tên đăng nhập',
      isShowHintText: true,
      textInputAction: TextInputAction.next,
    );
  }
}

class _PasswordTextField extends GetView<LoginController> {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTextField(
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
