import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class SwitchThemeController extends GetxController {
  //TODO: Implement SwitchThemeController
  final _box = GetStorage();
  static const _themeKey = 'app_theme';

  var selectedTheme = 'light'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void selectTheme(String theme) {
    selectedTheme.value = theme;
    _box.write(_themeKey, theme);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _applyTheme(theme);
    });
  }

  void _applyTheme(String theme) {
    switch (theme) {
      case 'light':
        Get.changeThemeMode(ThemeMode.light);  
        break;
      case 'dark':
        Get.changeThemeMode(ThemeMode.dark);  
        break;
      case 'system':
        Get.changeThemeMode(ThemeMode.system);  
        break;
      default:
    }
  }

  @override
  void onReady() {
    super.onReady();
    final saved = _box.read<String>(_themeKey) ?? 'light';
    selectedTheme.value = saved;
    _applyTheme(saved);
  }

  @override
  void onClose() {
    super.onClose();
  }

}
