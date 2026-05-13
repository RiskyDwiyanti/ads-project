import 'package:get/get.dart';

import '../controllers/home_judge_controller.dart';

class HomeJudgeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeJudgeController>(
      () => HomeJudgeController(),
    );
  }
}
