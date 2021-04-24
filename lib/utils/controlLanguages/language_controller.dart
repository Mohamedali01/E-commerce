
import 'package:e_commerce/utils/controlLanguages/read_write_db_languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  String _appLocale = 'en';

  String get appLocale => _appLocale;

  @override
  void onInit() {
    super.onInit();
    ReadWriteDBLanguages readWriteDBLanguages = ReadWriteDBLanguages();
    readWriteDBLanguages.readLocale().then((value) {
      if (value != null) _appLocale = value;
      Get.updateLocale(Locale(_appLocale));
      update();
    });
  }

  void changeLanguage(String language) async {
    ReadWriteDBLanguages readWriteDBLanguages = ReadWriteDBLanguages();
    await readWriteDBLanguages.writeLocale(language);
  }
}
