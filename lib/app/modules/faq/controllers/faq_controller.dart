import 'package:get/get.dart';

class FaqController extends GetxController {
  //TODO: Implement FaqController
  var openIndex = RxnInt();

  final faqs = [
    {
      'question': 'question1',
      'answer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'question': 'question2',
      'answer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'question': 'question3',
      'answer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    },
  ];

  void toggleFaq(int index) {
    if (openIndex.value == index) {
      openIndex.value = null; // tutup jika sudah terbuka
    } else {
      openIndex.value = index; // buka yang baru
    }
  }

  bool isOpen(int index) => openIndex.value == index;


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
