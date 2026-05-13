import 'package:fitpall/app/modules/athlete/home/views/home_view.dart';
import 'package:fitpall/app/modules/athlete/main/views/widgets/custom_buttom_nav_bar.dart';
import 'package:fitpall/app/modules/athlete/profile/views/profile_view.dart';
import 'package:fitpall/app/modules/athlete/transaction/views/transaction_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    final page = [
      const HomeView(),
      const TransactionView(),
      const ProfileView(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Obx(() => page[controller.selectedIndex.value]),
      bottomNavigationBar: const CustomButtomNavbar(),
    );
  }
}

