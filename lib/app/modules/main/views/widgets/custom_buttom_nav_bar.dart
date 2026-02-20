import 'dart:ui';

import 'package:fitpall/app/modules/main/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomButtomNavbar extends GetView<MainController> {
  const CustomButtomNavbar({super.key});
  
  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(iconPath: 'assets/icons/home_icon.svg', label: 'Home', isProfile: false),
      _NavItem(iconPath: 'assets/icons/transaction_icon.svg', label: 'Transaction', isProfile: false),
      _NavItem(iconPath: 'assets/icons/profile_icon.svg', label: 'Profile', isProfile: true),
    ];
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black.withOpacity(0.2), 
          width: 1,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.08),
        //     blurRadius: 20,
        //     spreadRadius: 2,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isSelected = controller.selectedIndex.value == index;
            final item = items[index];

            return GestureDetector(
              onTap: () => controller.changeIndex(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ============ PROFILE ============
                    // Lingkaran selalu tampil:
                    // - tidak aktif → lingkaran putih dengan border abu-abu
                    // - aktif       → lingkaran oranye
                    if (item.isProfile)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFFE8400)
                                : const Color(0xFFFFFFFF),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            item.iconPath,
                            width: 36,
                            height: 36,
                            
                          ),
                        ),
                      )

                    // ============ HOME & TRANSACTION ============
                    // Background bulat hanya muncul saat aktif
                    else
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(10),
                        
                        child: SvgPicture.asset(
                          item.iconPath,
                          width: 36,
                          height: 36,
                          colorFilter: ColorFilter.mode(
                            isSelected
                                ? const Color(0xFFFE8400)
                                : const Color(0xFF757575),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),

                    const SizedBox(height: 4),

                    // Label
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: isSelected
                            ? const Color(0xFFFE8400)
                            : const Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );    
  }
}

class _NavItem {
  final String iconPath;
  final String label;
  final bool isProfile;

  _NavItem({required this.iconPath, required this.label, required this.isProfile});
}