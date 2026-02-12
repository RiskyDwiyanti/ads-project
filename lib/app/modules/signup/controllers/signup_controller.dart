import 'dart:convert';
import 'package:fitpall/app/routes/app_pages.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

  // Step 1 
  final nameC = TextEditingController();
  final tbC = TextEditingController();
  final bbC = TextEditingController();
  var gender = 'Male'.obs;

  // Step 2
  final usernameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();
  var obscurePassword = true.obs;
  var obscureConfirm = true.obs;
  var isLoading = false.obs;

  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirm() {
    obscureConfirm.value = !obscureConfirm.value;
  }

  void goToStep2(){
    if (nameC.text.isEmpty ||
        tbC.text.isEmpty ||
        bbC.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    if (int.tryParse(tbC.text) == null ||
        int.tryParse(bbC.text) == null) {
      Get.snackbar('Error', 'Height and weight must be numbers');
      return;
    }

    Get.toNamed('/signup-step2');
  }

  Future<void> saveSignupLocal() async {
    final box = Hive.box('signupBox');

    await box.put('signup_data', {
      'name' : nameC.text.trim(),
      'height' : tbC.text.trim(),
      'weight': bbC.text.trim(),
      'gender': gender.value,
      'email': emailC.text.trim(),
      'phone': phoneC.text.trim(),
      'user_name': usernameC.text.trim(),
      'password': passwordC.text,
      'created_at': DateTime.now().toIso8601String(),
    });

    print('DATA SAVED TO LOCAL');
  }

  Future<void> submitAll() async {
    isLoading.value = true;

    try {
      /// 1️⃣ SIMPAN KE LOCAL DULU
      await saveSignupLocal();

      /// 2️⃣ KIRIM KE API
      final response = await http.post(
        Uri.parse('http://onseason-laravel.test/api/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameC.text.trim(),
          'height': tbC.text.trim(),
          'weight': bbC.text.trim(),
          'gender': gender.value,
          'email': emailC.text.trim(),
          'phone': phoneC.text.trim(),
          'username': usernameC.text.trim(),
          'password': passwordC.text,
          'password_confirmation': confirmPasswordC.text,
        }),
      );

      print('STATUS CODE: ${response.statusCode}');
      print('RESPONSE: ${response.body}');

      if (response.statusCode == 200) {
        print('MASUK SUCCESS BLOCK');
        /// ✔ sukses → hapus local data
        Hive.box('signupBox').clear();

        Get.offAllNamed(Routes.SIGNIN);
      } else {
        Get.snackbar('Info', 'Saved locally. Will sync later.');
      }
    } catch (e) {
      print('EXCEPTION: $e');
      Get.snackbar('Offline', 'Saved locally');
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameC.dispose();
    tbC.dispose();
    bbC.dispose();
    emailC.dispose();
    phoneC.dispose();
    passwordC.dispose();
    confirmPasswordC.dispose();
    super.onClose();
  }
}
