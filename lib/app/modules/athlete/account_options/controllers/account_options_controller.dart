import 'package:fitpall/app/routes/app_pages.dart';
import 'package:fitpall/app/theme/app_colors.dart';
import 'package:fitpall/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountOptionsController extends GetxController {

  void onSignOut(BuildContext context) {
    showDialog(
      context: Get.context!,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (_) => GestureDetector(
        onTap: () => Get.back(),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "sign_out_of_your_account?".tr,
                      style: AppText.Subheading_Bold.copyWith(color: Theme.of(context).colorScheme.onBackground)
                    ),

                    const SizedBox(height: 24),

                    Column(
                      children: [
                        
                        GestureDetector(
                          onTap: () async {
                            Get.back();
                            
                            try {
                              // Ambil token
                              final prefs = await SharedPreferences.getInstance();
                              final token = prefs.getString('token');

                              //Panggil API signout
                              await http.post(
                                Uri.parse('http://127.0.0.1:8000/api/auth/signout'),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Authorization': 'Bearer $token',
                                },
                              );
                            } catch (e) {
                              print('Logout error: $e');
                            } finally {
                              // Hapus dari SharedPreferences
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.clear();

                              // Navigasi ke halaman signin
                              Get.offAllNamed(Routes.SIGNIN);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                "yes_sign_out".tr,
                                style: AppText.Subheading_Bold.copyWith(color: AppColors.white),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14,),

                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                "cancel".tr,
                                style: AppText.Subheading_Bold.copyWith(color: Theme.of(context).colorScheme.onBackground),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onAccountDeletion() {
    showDialog(
      context: Get.context!,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (_) => GestureDetector(
        onTap: () => Get.back(),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "delete_account".tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "delete_account_desc".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6C6C6C),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFD0D0D0)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "cancel".tr,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              // TODO: panggil API delete account
                              // Get.offAllNamed(Routes.SIGNIN);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "delete".tr,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}