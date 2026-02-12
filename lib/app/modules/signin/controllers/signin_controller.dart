import 'dart:convert';

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
        Uri.parse('http://onseason-laravel.test/api/auth/signin'),
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
        final prefs = await SharedPreferences.getInstance();

        /// 🔥 SIMPAN TOKEN & USER
        await prefs.setString('token', data['token']);
        await prefs.setString('user', jsonEncode(data['user']));

        Get.snackbar('Success', 'Login success');
        Get.offAllNamed('/home');
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

  