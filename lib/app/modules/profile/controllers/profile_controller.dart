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
      'title': 'Change Password',
      'subtitle': 'Change your password here',
    },
    {
      'icon': 'assets/icons/person_icon.svg',
      'title': 'Account Options',
      'subtitle': '',
    },
  ];

  final preferenceMenus = [
    {
      'icon': 'assets/icons/language_icon.svg',
      'title': 'Change Language',
      'subtitle': "Pick language you'd like to use",
    },
    {
      'icon': 'assets/icons/palete_icon.svg',
      'title': 'Switch Theme',
      'subtitle': "Change the app's theme",
    },
  ];

  final helpMenus = [
    {
      'icon': 'assets/icons/faq_icon.svg',
      'title': 'FAQs',
      'subtitle': 'Explore frequently asked questions',
    },
    {
      'icon': 'assets/icons/feedback_icon.svg',
      'title': 'Send Feedback',
      'subtitle': 'Report any technical issues here',
    },
    {
      'icon': 'assets/icons/terms_icon.svg',
      'title': 'Terms of Use and Privacy Policy',
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
      case 'Change Password':
        Get.toNamed(Routes.CHANGE_PASSWORD);
        break;
      case 'Account Options':
        Get.toNamed(Routes.ACCOUNT_OPTIONS);
        break;
      case 'Change Language':
        Get.toNamed(Routes.CHANGE_LANGUAGE);
        break;
      case 'Switch Theme':
        Get.toNamed(Routes.SWITCH_THEME);
        break;
      case 'FAQs':
        Get.toNamed(Routes.FAQ);
        break;
      case 'Send Feedback':
        // Get.toNamed(Routes.FEEDBACK);
        break;
      case 'Terms of Use and Privacy Policy':
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
