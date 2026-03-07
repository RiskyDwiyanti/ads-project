import 'package:get/get.dart';

class FaqController extends GetxController {
  //TODO: Implement FaqController
  var openIndex = RxnInt();

  final faqs = [
    {
      'question': 'How do I change my password?',
      'answer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'question': 'Can I cancel a class that I have already booked?',
      'answer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'question': 'How do I delete my account?',
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
