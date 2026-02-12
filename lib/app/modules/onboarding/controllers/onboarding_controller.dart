import 'package:fitpall/app/data/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  var currentIndex = 0.obs;
  bool get isLastPage => currentIndex.value == onboardingPages.length - 1;

  // data untuk 3 halaman onboarding
  List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      image: 'image/onboarding1.jpg',
      title: 'Welcome to FitPal!',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi.',
    ),
    OnboardingModel(
      image: 'image/onboarding3.jpg',
      title: 'Discover your Fitness Adventure',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi.',
    ),
    // OnboardingModel(
    //   image: 'image/onboarding3.jpg',
    //   title: 'Your Fitness Story starts here!',
    //   description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi.',
    // ),
  ];

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
