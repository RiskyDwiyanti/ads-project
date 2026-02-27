import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 42, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: AppText.Heading1,
              ),

              const SizedBox(height: 20,),

              // ========================= USER CARD =========================
              _buildUserCard(),

              const SizedBox(height: 16),

              // ========================= STATS CARD =========================
              _buildStatsCard(),

              const SizedBox(height: 28),

              // ========================= ACCOUNT SETTINGS =========================
              Text('Account & Privacy', style: AppText.Heading2,),
              const SizedBox(height: 16),
              _buildMenuCard(controller.accountMenus),

              const SizedBox(height: 28),

              // ========================= PREFERENCE =========================
              Text('Preferences', style: AppText.Heading2,),
              const SizedBox(height: 16),
              _buildMenuCard(controller.preferenceMenus),

              const SizedBox(height: 28),

              // ========================= HELP CENTER =========================
              Text('Help Center', style: AppText.Heading2,),
              const SizedBox(height: 16),
              _buildMenuCard(controller.helpMenus),
            ],
          ),
        )
      ),
    );
  }

  // ========================= USER CARD =========================
  Widget _buildUserCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: ClipOval(
              child: Obx(() => SvgPicture.asset(
                controller.avatar.value,
                fit: BoxFit.cover,
                
                 // Fallback jika svg tidak ada
                placeholderBuilder: (_) => const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                ),
              )),
            ),
          ),

          const SizedBox(width: 24),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  controller.name.value,
                  style: AppText.Heading2,
                )),
                const SizedBox(height: 4),
                Obx(() => Text(
                  controller.phone.value,
                  style: AppText.Body.copyWith(
                    color: AppColors.grey,
                  ),
                )),
                const SizedBox(height: 2),
                Obx(() => Text(
                  controller.email.value,
                  style: AppText.Body.copyWith(
                    color: AppColors.grey,
                  ),
                )),
              ],
            )
          ),
        ],
      ),
    );
  }

  // ========================= STATS CARD =========================
  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Obx(() => Row(
        children: [
          Expanded(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: controller.weight.value,
                        style: AppText.Heading2,
                      ),
                      TextSpan(
                        text: ' kg',
                        style: AppText.Body.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Weight',
                  style: AppText.Body,
                ),
              ],
            )
          ),

          // Divider
          Container(
            width: 1,
            height: 40,
            color: AppColors.grey,
          ),

          // Height
          Expanded(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: controller.height.value,
                        style: AppText.Heading2,
                      ),
                      TextSpan(
                        text: ' cm',
                        style: AppText.Body.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Height',
                  style: AppText.Body,
                ),
              ],
            )
          ),
        ],
      ))
    );
  }

  // ========================= MENU CARD =========================
  Widget _buildMenuCard(List<Map<String, dynamic>> menus) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: List.generate(menus.length, (index) {
          final menu = menus[index];
          final isLast = index == menus.length - 1;
          return _buildMenuItem(
            iconPath: menu['icon'] as String,
            title: menu['title'] as String,
            subtitle: menu['subtitle'] as String,
            isLast: isLast,
          );
        }),
      ),
    );
  }

  // ========================= MENU ITEM =========================
  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    required String subtitle,
    required bool isLast,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => controller.onMenuTap(title),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            child: Row(
              children: [
                // Icon
                SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                ),

                const SizedBox(width: 14),

                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppText.Body_bold,
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: AppText.Body.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Arrow Icon
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF1A1A1A),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
