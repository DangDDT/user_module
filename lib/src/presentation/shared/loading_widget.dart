import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user_module/src/presentation/shared/shared.dart';

import '../../../core/core.dart';
import 'fade_scale_transition_wrapper.dart';

class LoadingWidget extends StatelessWidget {
  final String message;
  const LoadingWidget({Key? key, this.message = "Đang tải dữ liệu"})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FadeScaleTransitionWrapper(
      duration: const Duration(milliseconds: 610),
      child: SizedBox(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 300),
              LottieBuilder.asset(
                Assets.user_module$assets_animations_login_loading_json,
                width: 200,
              ),
              kGapH16,
              LoadingText(
                placeholder: message,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
