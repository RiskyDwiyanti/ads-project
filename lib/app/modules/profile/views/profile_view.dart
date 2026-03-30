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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 42, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: AppText.Heading1.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),

              const SizedBox(height: 20,),

              // ========================= USER CARD =========================
              _buildUserCard(context),

              const SizedBox(height: 16),

              // ========================= STATS CARD =========================
              _buildStatsCard(context),

              const SizedBox(height: 28),

              // ========================= ACCOUNT SETTINGS =========================
              Text('Account & Privacy', style: AppText.Heading2.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              const SizedBox(height: 16),
              _buildMenuCard(controller.accountMenus, context),

              const SizedBox(height: 28),

              // ========================= PREFERENCE =========================
              Text('Preferences', style: AppText.Heading2.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              const SizedBox(height: 16),
              _buildMenuCard(controller.preferenceMenus, context),

              const SizedBox(height: 28),

              // ========================= HELP CENTER =========================
              Text('Help Center', style: AppText.Heading2.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              const SizedBox(height: 16),
              _buildMenuCard(controller.helpMenus, context),
            ],
          ),
        )
      ),
    );
  }

  // ========================= USER CARD =========================
  Widget _buildUserCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
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

          const SizedBox(width: 24),

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

  // ========================= STATS CARD =========================
  Widget _buildStatsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
                        style: AppText.Heading2.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      TextSpan(
                        text: ' kg',
                        style: AppText.Body.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Weight',
                  style: AppText.Body.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            )
          ),

          // Divider
          Container(
            width: 1,
            height: 40,
            color: Theme.of(context).dividerColor,
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
                        style: AppText.Heading2.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      TextSpan(
                        text: ' cm',
                        style: AppText.Body.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  'Height',
                  style: AppText.Body.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            )
          ),
        ],
      ))
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
                        title,
                        style: AppText.Body_bold.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
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
