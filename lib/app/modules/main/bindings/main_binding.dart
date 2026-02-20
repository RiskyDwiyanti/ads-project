import 'package:fitpall/app/modules/home/controllers/home_controller.dart';
import 'package:fitpall/app/modules/profile/controllers/profile_controller.dart';
import 'package:fitpall/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
