import 'dart:ui';
import 'package:fitpall/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.onboardingPages.length,
        onPageChanged: (index) {
          controller.currentIndex.value = index;
        },
        itemBuilder: (context, index) {
          final data = controller.onboardingPages[index];

          return Stack(
            fit: StackFit.expand,
            children: [
              /// BACKGROUND
              Image.asset(data.image, fit: BoxFit.cover),

              /// BLUR BOTTOM
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 265,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 9),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color(0xFFD4D4D4).withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /// CONTENT
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: controller.buildTextSpans(
                          data.title, 
                          GoogleFonts.unbounded(
                            color: AppColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ), 
                    ),
                    const SizedBox(height: 12),
                    Text(
                      data.description,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 50),

                    /// BUTTON BAR
                    Obx(() {
                      final i = controller.currentIndex.value;
                      final isLast = controller.isLastPage;

                      return Row(
                        children: [
                          /// LEFT ARROWS
                          if (i == 0)
                            _ArrowButton(
                              icon: Icons.arrow_forward,
                              onTap: controller.nextPage,
                            ),

                          if (i == 1) ...[
                            _ArrowButton(
                              icon: Icons.arrow_back,
                              onTap: controller.prevPage,
                            ),
                            const SizedBox(width: 8),
                          ],

                          if (i == 2)
                            _ArrowButton(
                              icon: Icons.arrow_back,
                              onTap: controller.prevPage,
                            ),

                          /// PUSH RIGHT
                          const Spacer(),

                          /// RIGHT BUTTON
                          if (!isLast)
                            _SkipButton(
                              onTap: controller.skip,
                            )
                          else
                            _GetStartedButton(
                              onTap:
                                  controller.finishOnBoarding,
                            ),
                        ],
                      );
                    }),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// ======================
/// ARROW BUTTON
/// ======================
class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}

/// ======================
/// SKIP BUTTON
/// ======================
class _SkipButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SkipButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding:
            const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
        side: BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Text(
        'Skip',
        style: GoogleFonts.poppins(
          color: Colors.white, 
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// ======================
/// GET STARTED BUTTON
/// ======================
class _GetStartedButton extends StatelessWidget {
  final VoidCallback onTap;

  const _GetStartedButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        elevation: 0,
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        'Get Started',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
