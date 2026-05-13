import 'package:get/get.dart';

import '../controllers/profile_judge_controller.dart';

class ProfileJudgeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileJudgeController>(
      () => ProfileJudgeController(),
    );
  }
}
