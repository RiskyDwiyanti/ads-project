import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChangeLanguageController extends GetxController {
  //TODO: Implement ChangeLanguageController
  final _box = GetStorage();
  static const _langKey = 'app_language';

  var selectedLanguage = 'en'.obs;

  final languages = [
    {
      'code': 'en',
      'label': 'English (EN)',
      'flag': '🇬🇧',
      'locale': const Locale('en', 'US'),
    },
    {
      'code': 'id',
      'label': 'Indonesia (ID)',
      'flag': '🇮🇩',
      'locale': const Locale('id', 'ID'),
    },
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    final saved = _box.read<String>(_langKey) ?? 'en';
    selectedLanguage.value = saved;
    _applyLanguage(saved);
  }

  void selectLanguage(String code, Locale locale) {
    selectedLanguage.value = code;
    _box.write(_langKey, code);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.updateLocale(locale);
    });
  }

  void _applyLanguage(String code) {
    final lang = languages.firstWhere(
      (l) => l['code'] == code,
      orElse: () => languages.first,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.updateLocale(lang['locale'] as Locale);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
