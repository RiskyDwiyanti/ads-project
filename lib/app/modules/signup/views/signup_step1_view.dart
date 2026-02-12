import 'dart:ui';

import 'package:fitpall/app/routes/app_pages.dart';
import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/signup_controller.dart';

class SignUpStep1View extends GetView<SignupController> {
  const SignUpStep1View({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        toolbarHeight: 120,
        title: Text(
          'Sign Up', 
          style: GoogleFonts.unbounded(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: [
            // Background 
            Positioned(
              top: 100,
              left: 0,
              child: Image.asset(
                'assets/image/Shape (1).png',
                width: 250,
                opacity: const AlwaysStoppedAnimation(1.0),
              )
            ),

            Positioned(
              bottom: 20,
              right: 0,
              child: Image.asset(
                'assets/image/Shape.png',
                width: 250,
                opacity: const AlwaysStoppedAnimation(1.0),
              )
            ),

            // Content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    Text(
                      'Hey there!',
                      style: AppText.Heading1,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome to Fitpal!',
                      style: AppText.Subheading,
                    ),
                    
                    // Blur area
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10, 
                          sigmaY: 10
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          margin: const EdgeInsets.only(top: 32),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.01),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),

                              _label('Full Name'),
                              _input(controller.nameC, 'Jane Doe'),

                              const SizedBox(height: 16),

                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _label('TB'),
                                        _input(controller.tbC, ''),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _label('BB'),
                                        _input(controller.bbC, ''),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              _label('Gender'),
                              Obx(() => DropdownButtonFormField<String>(
                                value: controller.gender.value,
                                dropdownColor: Colors.black,
                                items: const [
                                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                                ],
                                onChanged: (v) => controller.gender.value = v!,
                                decoration: _decoration(),
                                style: const TextStyle(color: AppColors.black),
                              )),

                              const SizedBox(height: 32),

                              SizedBox(
                                width: double.infinity,
                                height: 46,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)
                                    ),
                                  ),
                                  onPressed: controller.goToStep2,
                                  child: const Text('Next',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 32),

                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Already have an account? ',
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Sign In',
                                        style: GoogleFonts.poppins(
                                          color: AppColors.primary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.toNamed(Routes.SIGNIN);
                                          },
                                        
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ) ,
      )
    );
  }
}

Widget _label(String text) => Padding(
  padding: const EdgeInsets.only(bottom: 14),
  child: Text(
    text,
    style: AppText.Body2_bold,
  ),
);

Widget _input(TextEditingController controller, String hint) {
  return TextField(
    controller: controller,
    style: const TextStyle(color: Colors.black),
    decoration: _decoration(hint: hint),
    keyboardType: TextInputType.text,
  );

  
}

InputDecoration _decoration({String? hint}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.black38),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 14,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: const BorderSide(color: Colors.black54),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: const BorderSide(color: Colors.black),
    ),
  );
}