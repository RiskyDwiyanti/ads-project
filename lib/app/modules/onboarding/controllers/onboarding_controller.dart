import 'package:fitpall/app/data/models/onboarding_model.dart';
import 'package:fitpall/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  var currentIndex = 0.obs;
  bool get isLastPage => currentIndex.value == onboardingPages.length - 1;

  // data untuk 3 halaman onboarding
  List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      image: 'image/onboarding.png',
      title: 'Welcome to Juliete!',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi.',
    ),
    OnboardingModel(
      image: 'image/onboarding3.jpg',
      title: 'Explore competitions around your area',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi.',
    ),
  ];

  final List<String> highlightWords = [
    'Juliete',
    'competitions',
  ];

  // Function buat convert text ke TextSpan
  List<TextSpan> buildTextSpans(
    String text,
    TextStyle baseStyle,
  ) {
    final List<TextSpan> spans = [];

    final words = text.split(' ');

    for (var word in words) {
      final cleanWord = word.replaceAll(RegExp(r'[^\w]'), '');

      final isHighlight = highlightWords.any(
        (h) => h.toLowerCase() == cleanWord.toLowerCase(),
      );

      spans.add(
        TextSpan(
          text: '$word ',
          style: isHighlight
              ? baseStyle.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                  decorationThickness: 3,
                  height: 1.4,
                )
              : baseStyle,
        ),
      );
    }

    return spans;
  }

  void nextPage() {
    if (currentIndex.value < onboardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      goToRegister();
    }
  }

  void prevPage(){
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void skip() {
    goToRegister();
  }

  void finishOnBoarding(){
    Get.offAllNamed('/signup-step1');
  }

  void goToRegister() {
    // ganti sesuai route kamu
    Get.offAllNamed('/signup-step1');
  }
}
