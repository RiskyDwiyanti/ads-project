import 'package:get/get.dart';

import '../controllers/scoring_controller.dart';

class ScoringBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScoringController>(
      () => ScoringController(),
    );
  }
}
