import 'package:get/get.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController
  final Map<String, List<Map<String, dynamic>>> notifications = {
    'Newest': [
      {
        'id': '1',
        'icon': 'assets/icons/recipt_icon.svg',
        'title': 'Payment confirmation',
        'message': "Your payment for Men's Sport Physique Class was successful.",
        'time': '5h',
      },
    ],
    'Last week': [
      {
        'id': '2',
        'icon': 'assets/icons/terms_icon.svg',
        'title': 'Terms and Condition Update',
        'message': "We've updated our terms and condition.",
        'time': '2d',
      },
      {
        'id': '3',
        'icon': 'assets/icons/maintenance_icon.svg',
        'title': 'Maintenance Notice',
        'message': "We're regularly updates Juliete to make a better experience for you.",
        'time': '5d',
      },
    ],
  };


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
