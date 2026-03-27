import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/switch_theme_controller.dart';

class SwitchThemeView extends GetView<SwitchThemeController> {
  const SwitchThemeView({super.key});
  @override
  Widget build(BuildContext context) {
    final themes = [
      {
        'value': 'light',
        'label': 'Light',
        'icon': 'assets/icons/sun_icon.svg',
      },
      {
        'value': 'dark',
        'label': 'Dark',
        'icon': 'assets/icons/moon_icon.svg',
      },
      {
        'value': 'system',
        'label': 'System default',
        'icon': 'assets/icons/palete_icon.svg',
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('Switch Theme', style: AppText.Heading2.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
                ],
              ),
            ),

            const SizedBox(height: 20,),

            // ========================== THEME LIST ========================== 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Obx(() => Column(
                  children: List.generate(themes.length, (index) {
                    final theme = themes[index];
                    final isSelected = controller.selectedTheme.value == theme['value'];
                    final isLast = index == themes.length - 1;

                    return Column(
                      children: [
                        _buildThemeItem(
                          context: context,
                          iconPath: theme['icon']!,
                          label: theme['label']!,
                          isSelected: isSelected,
                          onTap: () => controller.selectTheme(theme['value']!),
                        ),
                        if (!isLast)
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Theme.of(context).dividerColor,
                            indent: 16,
                            endIndent: 16,
                          )
                      ],
                    );
                  }),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================== THEME ITEM ========================== 
  Widget _buildThemeItem({
    required BuildContext context,
    required String iconPath,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          children: [
            // Icon
            SvgPicture.asset(
              iconPath,
              width: 26,
              height: 26,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onBackground, 
                BlendMode.srcIn,
              ),
            ),

            const SizedBox(width: 14,),

            // label
            Expanded(
              child: Text(
                label,
                style: AppText.Body_bold.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),

            // checkmark 
            if (isSelected)
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
