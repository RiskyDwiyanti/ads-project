import 'dart:convert';

import 'package:fitpall/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  var name = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;
  var weight = ''.obs;
  var height = ''.obs;
  var avatar = 'assets/icons/profile_icon.svg'.obs;

  var isLoading = false.obs;

  final accountMenus = [
    {
      'icon': 'assets/icons/lock_icon.svg',
      'title': 'change_password',
      'subtitle': 'change_password_desc',
    },
    {
      'icon': 'assets/icons/person_icon.svg',
      'title': 'account_options',
      'subtitle': '',
    },
  ];

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
        Uri.parse('http://onseason-laravel.test/api/auth/profile'),
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
        weight.value = data['weight']?.toString() ?? '';
        height.value = data['height']?.toString() ?? '';
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
      case 'change_password':
        Get.toNamed(Routes.CHANGE_PASSWORD);
        break;
      case 'account_options':
        Get.toNamed(Routes.ACCOUNT_OPTIONS);
        break;
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

}
