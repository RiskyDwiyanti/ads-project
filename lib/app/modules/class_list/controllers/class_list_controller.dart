import 'package:get/get.dart';

class ClassListController extends GetxController {
  var selectedGender = 'All'.obs;

  final filters = ['All', 'Male', 'Female'];

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  final allClasses = [
    {
      'id': '1',
      'image': 'image/class1.png',
      'title': 'Men\'s Sport Physique',
      'date': '27 Jan',
      'gender': 'Male',
      'price': 'Rp. 500.000',
      'time': '09:00',
    },
    {
      'id': '2',
      'image': 'image/class2.png',
      'title': 'Master Over 45th Years',
      'date': '28 Jan',
      'gender': 'Male',
      'price': 'Rp. 500.000',
      'time': '10:00',
    },
    {
      'id': '3',
      'image': 'image/class1.png',
      'title': 'Men\'s Sport Physique',
      'date': '27 Jan',
      'gender': 'Female',
      'price': '500000',
      'time': '11:00',
    },
  ];

  List<Map<String, dynamic>> get filteredClasses {
    if (selectedGender.value == 'All') return allClasses;
    return allClasses
        .where((c) => c['gender'] == selectedGender.value)
        .toList();
  }

  void onBookTap(String classId) {
    // Cari data class berdasarkan id
    final classItem = allClasses.firstWhere((c) => c['id'] == classId);
    // TODO: navigasi ke halaman booking
    // Get.toNamed(Routes.BOOKING, arguments: classItem);
  }

  // ✅ Navigasi ke ClassDetailView dengan kirim semua data sebagai arguments
  void onDetailTap(String classId) {
    final classItem = allClasses.firstWhere((c) => c['id'] == classId);
    Get.toNamed('/class-detail', arguments: classItem);
  }
}