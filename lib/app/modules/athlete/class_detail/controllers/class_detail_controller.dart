import 'package:get/get.dart';

class ClassDetailController extends GetxController {
  //TODO: Implement ClassDetailController
  late Map<String, dynamic> classData;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print("Arguments: ${Get.arguments}");
    classData = Get.arguments ?? {};
  }

  
}
