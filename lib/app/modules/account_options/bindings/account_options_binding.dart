import 'package:get/get.dart';

import '../controllers/account_options_controller.dart';

class AccountOptionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountOptionsController>(
      () => AccountOptionsController(),
    );
  }
}
