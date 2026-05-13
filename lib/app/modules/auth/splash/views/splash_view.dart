import 'package:fitpall/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: AnimatedBuilder(
        animation: controller.animationController,

        builder: (context, child) {
          return Center(
            child: Opacity(
              opacity: controller.fadeAnimation.value,

              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  // LOGO (DIAM)
                  SvgPicture.asset(
                    'assets/image/logo.svg',
                    width: 50,
                    height: 50,
                  ),

                  const SizedBox(width: 12),

                  // TEXT → DORONG LOGO
                  AnimatedSize(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut, // no bounce
                    alignment: Alignment.centerLeft,

                    child: ClipRect(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor: controller.textProgress.value,

                        child: Row(
                          mainAxisSize: MainAxisSize.min,

                          children: List.generate(
                            controller.totalLetters,

                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 1,
                              ),

                              child: Opacity(
                                opacity: controller
                                    .letterAnimations[index]
                                    .value,

                                child: Transform.translate(
                                  offset: Offset(
                                    0,
                                    controller
                                        .letterVerticalOffsets[index],
                                  ),

                                  child: SvgPicture.asset(
                                    'assets/text/letter_${index + 1}.svg',
                                    height: controller
                                        .letterHeights[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
