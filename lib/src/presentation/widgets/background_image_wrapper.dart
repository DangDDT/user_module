import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

class ImageBackgroundWrapper extends StatelessWidget {
  final Widget child;
  const ImageBackgroundWrapper({super.key, required this.child});

  static final ModuleConfig _moduleConfig =
      Get.find<ModuleConfig>(tag: ModuleConfig.tag);

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Positioned.fill(
        child: _BackgroundImage(
          imageBackground: _moduleConfig.loginViewConfig?.imageBackground,
        ),
      ),
      Positioned(
        child: child,
      )
    ]);
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
