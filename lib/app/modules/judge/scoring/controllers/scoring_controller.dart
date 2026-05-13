import 'package:get/get.dart';

class ScoringController extends GetxController {
  //TODO: Implement ScoringController
  final selectedPaticipant = {}.obs;

  final participants = [
    {
      'id': 1,
      'name': "Jamez Waltz",
      'image': "assets/image/participant1.png",
    },
    {
      'id': 2,
      'name': "Robin Smith",
      'image': "assets/image/judge1.png",
    },
    {
      'id': 3,
      'name': "Leonardo",
      'image': "assets/image/judge1.png",
    },
    {
      'id': 4,
      'name': "Kevin Bacon",
      'image': "assets/image/judge1.png",
    },
    {
      'id': 5,
      'name': "Mark Norris",
      'image': "assets/image/judge1.png",
    },
    {
      'id': 6,
      'name': "Nathaniel Krow",
      'image': "assets/image/judge1.png",
    },
    {
      'id': 7,
      'name': "Richard Brown",
      'image': "assets/image/judge1.png",
    },
    {
      'id': 8,
      'name': "Damian Scott",
      'image': "assets/image/judge1.png",
    },
    {
      'id': 9,
      'name': "Dylan Hawks",
      'image': "assets/image/judge1.png",
    },
    {
      'id': 10,
      'name': "Thomas",
      'image': "assets/image/judge1.png",
    }
  ].obs;

  void toggleParticipant(int id) {
    if (selectedPaticipant.containsKey(id)) {
      selectedPaticipant.remove(id);
    } else {
      selectedPaticipant[id] = true;
    }
  }

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
