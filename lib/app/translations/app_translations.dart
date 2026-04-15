import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  static Map<String, Map<String, String>> translations = {};

  static Future<void> loadTranslations() async {
    final en = await rootBundle.loadString('assets/translations/en.json');
    final id = await rootBundle.loadString('assets/translations/id.json');

    translations = {
      'en_US': Map<String, String>.from(json.decode(en)),
      'id_ID': Map<String, String>.from(json.decode(id)),
    };
  }

  @override
  Map<String, Map<String, String>> get keys => translations;
}