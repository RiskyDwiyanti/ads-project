import 'dart:convert';

import 'package:fitpall/app/routes/app_pages.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileJudgeController extends GetxController {
  //TODO: Implement ProfileJudgeController
  var name = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;
  var avatar = 'assets/icons/profile_icon.svg'.obs;

  var isLoading = false.obs;

  final preferenceMenus = [
    {
      'icon': 'assets/icons/language_icon.svg',
      'title': 'change_language',
      'subtitle': "change_language_desc",
    },
    {
      'icon': 'assets/icons/palete_icon.svg',
      'title': 'switch_theme',
      'subtitle': "switch_theme_desc",
    },
  ];

  final helpMenus = [
    {
      'icon': 'assets/icons/faq_icon.svg',
      'title': 'faqs',
      'subtitle': 'faqs_desc',
    },
    {
      'icon': 'assets/icons/feedback_icon.svg',
      'title': 'send_feedback',
      'subtitle': 'send_feedback_desc',
    },
    {
      'icon': 'assets/icons/terms_icon.svg',
      'title': 'terms_of_use_and_privacy_policy',
      'subtitle': '',
    },
  ];

  // Api
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';

      print("TOKEN: $token");

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/auth/profile'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ); 

      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'];

        name.value = data['name'] ?? '';
        email.value = data['email'] ?? '';
        phone.value = data['phone'] ?? '';
      }
    } catch (e) {
      print("Error fetch profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onMenuTap(String title) {
    // Handle navigasi sesuai menu
    switch (title) {
      case 'change_language':
        Get.toNamed(Routes.CHANGE_LANGUAGE);
        break;
      case 'switch_theme':
        Get.toNamed(Routes.SWITCH_THEME);
        break;
      case 'faqs':
        Get.toNamed(Routes.FAQ);
        break;
      case 'send_feedback':
        // Get.toNamed(Routes.FEEDBACK);
        break;
      case 'terms_of_use_and_privacy_policy':
        // Get.toNamed(Routes.TERMS);
        break;
    }
  }

  void onSignOut(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (_) => GestureDetector(
        onTap: () => Get.back(),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'sign_out_of_your_account?'.tr,
                      style: AppText.Subheading_Bold.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Tombol Yes Sign Out
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                        try {
                          final prefs = await SharedPreferences.getInstance();
                          final token = prefs.getString('token');
                          await http.post(
                            Uri.parse('http://127.0.0.1:8000/api/auth/logout'),
                            headers: {
                              'Content-Type': 'application/json',
                              'Authorization': 'Bearer $token',
                            },
                          );
                        } catch (e) {
                          print('Logout error: $e');
                        } finally {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.clear();
                          Get.offAllNamed(Routes.SIGNIN);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            'yes_sign_out'.tr,
                            style: AppText.Subheading_Bold.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Tombol Cancel
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            'cancel'.tr,
                            style: AppText.Subheading_Bold.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
