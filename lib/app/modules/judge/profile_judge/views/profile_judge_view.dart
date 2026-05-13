import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/profile_judge_controller.dart';

class ProfileJudgeView extends GetView<ProfileJudgeController> {
  const ProfileJudgeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 42, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========================== HEADER ========================== 
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back,
                        size: 26,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text('Profile', style: AppText.Heading1.copyWith(color: Theme.of(context).colorScheme.onBackground)),
                  ],
                ),
              ),

              const SizedBox(height: 20,),

              // ========================= USER CARD =========================
              _buildUserCard(context),

              const SizedBox(height: 16),

              // ========================= PREFERENCE =========================
              Text("preferences".tr, style: AppText.Heading2.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              const SizedBox(height: 16),
              _buildMenuCard(controller.preferenceMenus, context),

              const SizedBox(height: 28),

              // ========================= HELP CENTER =========================
              Text("help_center".tr, style: AppText.Heading2.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              const SizedBox(height: 16),
              _buildMenuCard(controller.helpMenus, context),

              const SizedBox(height: 28),

              // ========================= SIGN OUT BUTTON =========================
              GestureDetector(
                onTap: () => controller.onSignOut(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE9E9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'sign_out'.tr,
                      style: AppText.Body_bold.copyWith(color: Color(0xFFD80027)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  // ========================= USER CARD =========================
  Widget _buildUserCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
              color: Theme.of(context).cardColor,
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

          const SizedBox(width: 32),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  controller.name.value,
                  style: AppText.Heading2.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                )),
                const SizedBox(height: 4),
                Obx(() => Text(
                  controller.phone.value,
                  style: AppText.Body.copyWith(
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                )),
                const SizedBox(height: 2),
                Obx(() => Text(
                  controller.email.value,
                  style: AppText.Body.copyWith(
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                )),
              ],
            )
          ),
        ],
      ),
    );
  }

  // ========================= MENU CARD =========================
  Widget _buildMenuCard(List<Map<String, dynamic>> menus, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
            context: context
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
    required BuildContext context
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
                  color: Theme.of(context).colorScheme.onBackground,
                ),

                const SizedBox(width: 14),

                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.toString().tr,
                        style: AppText.Body_bold.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle.toString().tr,
                          style: AppText.Body.copyWith(
                            color: Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Arrow Icon
                Icon(
                  Icons.chevron_right_rounded,
                  color: Theme.of(context).colorScheme.onBackground,
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
