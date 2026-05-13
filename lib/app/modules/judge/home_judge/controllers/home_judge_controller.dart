import 'package:get/get.dart';

class HomeJudgeController extends GetxController {
  //TODO: Implement HomeJudgeController

  var selectedGender = 'All'.obs;
  var currentBannerIndex = 0.obs;

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  void changeBannerIndex(int index) {
    currentBannerIndex.value = index;
  }

  List<Map<String, String>> get banners => [
    {
      'image': 'assets/image/banner1.png',
      'title': 'Become a member and get 25% discount!',
      'subtitle': 'Valid until March 2026',
    },
    {
      'image': 'assets/image/banner1.png',
      'title': 'Become a member and get 25% discount!',
      'subtitle': 'Valid until March 2026',
    },
    {
      'image': 'assets/image/banner1.png',
      'title': 'Become a member and get 25% discount!',
      'subtitle': 'Valid until March 2026',
    },
  ];

  // ==================== LOCATION ====================
  var selectedLocationId = '1'.obs;

  // Daftar lokasi gym 
  final locations = [
    {
      'id': '1',
      'name': 'GymFit Malang',
      'city': 'Malang',
      'distance': '6km',
      'image': 'image/gym1.png',
    },
    {
      'id': '2',
      'name': 'GymFit Malang',
      'city': 'Malang',
      'distance': '6km',
      'image': 'image/gym1.png',
    },
    {
      'id': '3',
      'name': 'GymFit Malang',
      'city': 'Malang',
      'distance': '6km',
      'image': 'image/gym1.png',
    },
    {
      'id': '4',
      'name': 'GymFit Malang',
      'city': 'Malang',
      'distance': '6km',
      'image': 'image/gym1.png',
    },
  ];

  void selectLocation(String id) {
    selectedLocationId.value = id;
  }

  final activeClasses = [
    {
      'id': '1',
      'title': "Men’s Sport Physique",
      'gender': 'Male',
      'stage': 'Semifinal',
      'image': 'assets/image/class1.png',
    },
    {
      'id': '1',
      'title': "Master Over 45th Year",
      'gender': 'Male',
      'stage': 'Semifinal',
      'image': 'assets/image/class2.png',
    }
  ];

  List<Map<String, dynamic>> get filteredActiveClasses {
    if (selectedGender.value == 'All') {
      return activeClasses;
    } else {
      return activeClasses.where((classItem) => classItem['gender'] == selectedGender.value).toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    print('HomeController initialized');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    print('HomeController disposed');
  }

}
