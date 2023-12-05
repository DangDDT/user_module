import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/core.dart';

class LogoAndAppNameWrapper extends StatelessWidget {
  final List<Widget> children;
  const LogoAndAppNameWrapper({super.key, required this.children});

  static final ModuleConfig _moduleConfig =
      Get.find<ModuleConfig>(tag: ModuleConfig.tag);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Logo(logo: _moduleConfig.loginViewConfig?.logo),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _AppName(
                appName: _moduleConfig.loginViewConfig?.appName ?? 'App Name',
              ),
            ),
            Positioned(
              top: 25,
              left: 0,
              right: 0,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  kTheme.colorScheme.primary,
                  BlendMode.srcATop,
                ),
                child: LottieBuilder.asset(
                  Assets.user_module$assets_animations_flower_animation_json,
                  width: 300,
                  reverse: true,
                  repeat: true,
                ),
              ),
            ),
          ],
        ),
        kGapH24,
        ...children,
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  final Widget? logo;
  const _Logo({this.logo});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: height * 0.2,
      height: height * 0.2,
      child: logo ??
          Image.asset(
            Assets.user_module$assets_images_logo_png,
            fit: BoxFit.cover,
          ),
    );
  }
}

class _AppName extends StatelessWidget {
  final String appName;
  const _AppName({required this.appName});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
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
      ),
    );
  }
}
