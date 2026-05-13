import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});
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
                  Text("reset_password".tr, style: AppText.Heading2.copyWith(color: Theme.of(context).colorScheme.onBackground)),
                ],
              ),
            ),

            const SizedBox(height: 20,),

            // ========================== FORM CARD ========================== 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // New Password
                    Text("new_password".tr, style: AppText.Body_bold.copyWith(color: Theme.of(context).colorScheme.onBackground)),
                    const SizedBox(height: 12,),
                    Obx(() => _buildPasswordField(
                      controller: controller.newPasswordController,
                      hint: "at_least_6_characters".tr,
                      isVisible: controller.isNewPasswordVisible.value,
                      onToggle: controller.toggleNewPassword,
                      context: context,
                    )),

                    const SizedBox(height: 20,),

                    // Confirm Password
                    Text("confirm_password".tr, style: AppText.Body_bold.copyWith(color: Theme.of(context).colorScheme.onBackground)),
                    const SizedBox(height: 12,),
                    Obx(() => _buildPasswordField(
                      controller: controller.confirmPasswordController,
                      hint: "at_least_6_characters".tr,
                      isVisible: controller.isConfirmPasswordVisible.value,
                      onToggle: controller.toggleConfirmPassword,
                      context: context,
                    )),

                    const SizedBox(height: 32,),

                    // Save Changes Button
                    Obx(() => GestureDetector(
                      onTap: controller.isLoading.value ? null : controller.saveChanges,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: controller.isLoading.value
                            ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                            : Text(
                              "save_changes".tr,
                              style: AppText.Subheading_Bold.copyWith(color: AppColors.white),
                            ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================== PASSWORD FIELD ========================== 
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
    required BuildContext context,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      style: AppText.Body.copyWith(color: Theme.of(context).colorScheme.onBackground),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppText.Body.copyWith(color: Theme.of(context).colorScheme.onTertiary),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        filled: false,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 1),
        ),
        suffixIcon: GestureDetector(
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              isVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
              color: Theme.of(context).colorScheme.onBackground,
              size: 22,
            ),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(),
      ),
    );
  }
}
