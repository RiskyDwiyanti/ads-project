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
                  Text("account_options".tr, style: AppText.Heading2.copyWith(color: Theme.of(context).colorScheme.onBackground)),
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
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // Sign Out
                    _buildMenuItem(
                      iconPath: 'assets/icons/signout_icon.svg',
                      title: 'sign_out',
                      subtitle: 'sign_out_desc',
                      onTap: () => controller.onSignOut(context),
                      isLast: false,
                      context: context
                    ),

                    const SizedBox(height: 20,),

                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Theme.of(context).dividerColor,
                      indent: 16,
                      endIndent: 16,
                    ),

                    const SizedBox(height: 20,),

                    // Account Delete
                    _buildMenuItem(
                      iconPath: 'assets/icons/trash_icon.svg',
                      title: 'account_deletion', 
                      subtitle: 'account_deletion_desc', 
                      onTap: controller.onAccountDeletion, 
                      isLast: true,
                      context: context
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
    required BuildContext context,
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
              color: Theme.of(context).colorScheme.onBackground,
            ),

            const SizedBox(width: 20,),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toString().tr,
                    style: AppText.Body_bold.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    subtitle.toString().tr,
                    style: AppText.Body.copyWith(color: Theme.of(context).colorScheme.onBackground),
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
