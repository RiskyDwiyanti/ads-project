import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  var name = 'Jane Doe'.obs;
  var phone = '+62-8123-4567-890'.obs;
  var email = 'hey@mail.com'.obs;
  var weight = '65'.obs;
  var height = '175'.obs;
  var avatar = 'assets/icons/profile_icon.svg'.obs;

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

  void onMenuTap(String title) {
    // Handle navigasi sesuai menu
    switch (title) {
      case 'Change Password':
        // Get.toNamed(Routes.CHANGE_PASSWORD);
        break;
      case 'Account Options':
        // Get.toNamed(Routes.ACCOUNT_OPTIONS);
        break;
      case 'Change Language':
        // Get.toNamed(Routes.LANGUAGE);
        break;
      case 'Switch Theme':
        // Get.toNamed(Routes.THEME);
        break;
      case 'FAQs':
        // Get.toNamed(Routes.FAQ);
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
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
