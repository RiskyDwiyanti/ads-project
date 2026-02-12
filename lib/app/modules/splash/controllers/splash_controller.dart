import 'dart:async';
import 'package:fitpall/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SplashController extends GetxController
    with GetTickerProviderStateMixin {

  late AnimationController animationController;

  late Animation<double> fadeAnimation;
  late Animation<double> textProgress;

  // Animasi huruf
  List<Animation<double>> letterAnimations = [];

  final int totalLetters = 7;

  final List<double> letterHeights = [
    28.0,
    20.0,
    28.0,
    28.0,
    22.0,
    28.0,
    22.0,
  ];

  final List<double> letterVerticalOffsets = [
    0.0,
    3.0,
    0.0,
    0.0,
    3.5,
    0.0,
    3.5,
  ];

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Fade in
    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.25,
          curve: Curves.easeIn,
        ),
      ),
    );

    // Text muncul → dorong logo
    textProgress = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.4,
          0.7,
          curve: Curves.easeOut, // no bounce
        ),
      ),
    );

    // Animasi huruf
    for (int i = 0; i < totalLetters; i++) {
      double start = 0.35 + (i * 0.05);
      double end = start + 0.10;

      final anim = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval(start, end, curve: Curves.easeIn),
        ),
      );

      letterAnimations.add(anim);
    }

    // Delay start
    Future.delayed(const Duration(milliseconds: 400), () {
      animationController.forward();
    });

    // Listener selesai
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAllNamed(Routes.ONBOARDING);
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
