import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    try {
      print('=== HomeBinding CALLED ===');
      Get.lazyPut<HomeController>(() => HomeController());
      print('=== HomeBinding SUCCESS ===');
    } catch (e, stack) {
      print('=== HomeBinding ERROR: $e ===');
      print(stack);
    }
  }
}
