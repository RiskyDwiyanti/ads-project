import 'dart:convert';

import 'package:fitpall/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SigninController extends GetxController {
  //TODO: Implement SigninController
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();

  var isLoading = false.obs;
  var obscurePassword = true.obs;

  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    if (usernameC.text.isEmpty || passwordC.text.isEmpty) {
      Get.snackbar('Error', 'Username and password required');
      return;
    }

    // if (!GetUtils.isEmail(usernameC.text.trim())) {
    //   Get.snackbar('Error', 'Invalid email');
    //   return;
    // }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/auth/signin'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': usernameC.text.trim(),
          'password': passwordC.text,
        }),
      );

      print('STATUS CODE : ${response.statusCode}');
      print('RESPONSE    : ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        print('=== STEP 1: masuk if ===');

        final prefs = await SharedPreferences.getInstance();
        print('=== STEP 2: prefs ready ===');

        /// 🔥 SIMPAN TOKEN & USER
        await prefs.setString('token', data['token']);
        print('=== STEP 3: token saved ===');
        await prefs.setString('user', jsonEncode(data['user']));
        print('=== STEP 4: user saved ===');

        final user = data['user'];
        if (user == null) {
          Get.snackbar('Error', 'User data is null');
          return;
        }

        final role = user['role']?.toString().trim().toLowerCase();
        print('=== STEP 5: role = $role ===');

        print('USER: ${data['user']}');
        print('ROLE: ${data['user']?['role']}');

        if (role == 'athlete') {
          print('=== STEP 6: navigating to HOME ===');
          Get.offAllNamed(Routes.MAIN);
          print('=== STEP 7: after navigate ===');
        } else if (role == 'judge') {
          Get.offAllNamed(Routes.HOME_JUDGE);
        } else {
          Get.snackbar('Error', 'Unknown user role');
        }
      } else {
        Get.snackbar(
          'Error',
          data['message'] ?? 'Login failed',
        );
      }
    } catch (e) {
      print('EXCEPTION : $e');
      Get.snackbar('Error', 'Server error');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}

  