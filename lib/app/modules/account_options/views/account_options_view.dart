import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/account_options_controller.dart';

class AccountOptionsView extends GetView<AccountOptionsController> {
  const AccountOptionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================== HEADER ========================== 
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 62, 20, 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('Account options', style: AppText.Heading2),
                ],
              ),
            ),

            const SizedBox(height: 20,),

            // ========================== MENU CARD ========================== 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // Sign Out
                    _buildMenuItem(
                      iconPath: 'assets/icons/signout_icon.svg',
                      title: 'Sign Out',
                      subtitle: 'Sign out from your current device.',
                      onTap: controller.onSignOut,
                      isLast: false,
                    ),

                    const SizedBox(height: 20,),

                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFF0F0F0),
                      indent: 16,
                      endIndent: 16,
                    ),

                    const SizedBox(height: 20,),

                    // Account Delete
                    _buildMenuItem(
                      iconPath: 'assets/icons/trash_icon.svg',
                      title: 'Account Deletion', 
                      subtitle: 'Find out how you can permanently delete your existed account.', 
                      onTap: controller.onAccountDeletion, 
                      isLast: true,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isLast,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            SvgPicture.asset(
              iconPath,
              width: 26,
              height: 26,
            ),

            const SizedBox(width: 20,),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppText.Body_bold,
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    subtitle,
                    style: AppText.Body,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
