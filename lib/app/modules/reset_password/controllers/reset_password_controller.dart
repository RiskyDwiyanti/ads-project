import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isNewPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isLoading = false.obs;

  void toggleNewPassword() =>
      isNewPasswordVisible.value = !isNewPasswordVisible.value;

  void toggleConfirmPassword() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  void saveChanges() {
    final newPass = newPasswordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    // Validasi
    if ( newPass.isEmpty || confirm.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPass.length < 6) {
      Get.snackbar(
        'Error',
        'New password must be at least 6 characters.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPass != confirm) {
      Get.snackbar(
        'Error',
        'New password and confirm password do not match.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // TODO: Panggil API ganti password di sini
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      Get.back();
      Get.snackbar(
        'Success',
        'Password changed successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}