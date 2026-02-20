import 'package:get/get.dart';

class MainController extends GetxController {
  //TODO: Implement MainController

  var selectedIndex = 0.obs;

  void changeIndex(int index) => selectedIndex.value = index;
}
