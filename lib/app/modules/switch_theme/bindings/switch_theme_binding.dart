import 'package:get/get.dart';

import '../controllers/switch_theme_controller.dart';

class SwitchThemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SwitchThemeController>(
      () => SwitchThemeController(),
    );
  }
}
