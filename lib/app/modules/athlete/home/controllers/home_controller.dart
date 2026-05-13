import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var selectedGender = 'All'.obs;
  var selected2Gender = 'All'.obs;
  var currentBannerIndex = 0.obs;

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  void select2Gender(String gender) {
    selected2Gender.value = gender;
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

  // HOME CONTROLLER (FIXED PART)
  Map<String, String> get selectedLocation {
    return locations.firstWhere(
      (loc) => loc['id'] == selectedLocationId.value,
      orElse: () => locations.first,
    );
  }

  List<Map<String, dynamic>> get featuredClasses => [
    {
      'image': 'image/class1.png',
      'title': 'Men\'s Sport Physique',
      'date': '27 Jan',
      'gender': 'Male',
      'price': 500000,
      'time': '09:00',
    },
    {
      'image': 'image/class2.png',
      'title': 'Master Over 45th Years',
      'date': '28 Jan',
      'gender': 'Male',
      'price': 500000,
      'time': '10:00',
    },
    {
      'image': 'image/class1.png',
      'title': 'Men\'s Sport Physique',
      'date': '27 Jan',
      'gender': 'Female',
      'price': 500000,
      'time': '11:00',
    },
  ];

  List <Map<String, String>> get judges => [
    {
      'name': 'John Doe',
      'description': 'Lorem ipsum dolor sit amet',
      'image': 'assets/image/judge3.png',
    },
    {
      'name': 'John Doe',
      'description': 'Lorem ipsum dolor sit amet',
      'image': 'assets/image/judge2.png',
    },
    {
      'name': 'John Doe',
      'description': 'Lorem ipsum dolor sit amet',
      'image': 'assets/image/judge1.png',
    },
  ];

  List<Map<String, dynamic>> get filteredClasses {
    if (selectedGender.value == 'All') {
      return featuredClasses;
    } else {
      return featuredClasses.where((classItem) => classItem['gender'] == selectedGender.value).toList();
    }
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
    if (selected2Gender.value == 'All') {
      return activeClasses;
    } else {
      return activeClasses.where((classItem) => classItem['gender'] == selected2Gender.value).toList();
    }
  }

  @override
  void onInit() {
    try {
      print('=== HomeController onInit ===');
      super.onInit();
      print('=== HomeController onInit SUCCESS ===');
    } catch (e, stack) {
      print('=== HomeController onInit ERROR: $e ===');
      print(stack);
    }
  }

  @override
  void onClose() {
    super.onClose();
    print('HomeController disposed');
  }

}
