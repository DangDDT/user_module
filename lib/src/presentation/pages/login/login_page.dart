import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:user_module/src/presentation/widgets/custom_text_field.dart';

import '../../../../core/core.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  final String? imageBackground;
  final Widget? logo;
  final String appName;
  const LoginPage({
    super.key,
    this.imageBackground,
    this.logo,
    this.appName = 'Wedding Service',
  });

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
                child: _BackgroundImage(imageBackground: imageBackground),
              ),
              Positioned(
                child: _MainView(logo: logo, appName: appName),
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
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.25),
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
      child: logo ??
          const FlutterLogo(
            style: FlutterLogoStyle.markOnly,
            size: 100,
            curve: Curves.bounceIn,
            duration: Duration(seconds: 1),
          ),
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
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.dancingScript().fontFamily,
          ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          CustomTextField(
            labelText: 'Tên đăng nhập',
            isShowHintText: true,
          ),
          kGapH12,
          CustomTextField(
            labelText: 'Mật khẩu',
            isShowHintText: true,
          ),
        ],
      ),
    );
  }
}
