import 'package:shared_preferences/shared_preferences.dart';

class ReadWriteDBLanguages {
  Future<String> readLocale() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('locale');
  }

  Future<void> writeLocale(String language) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('locale', language);
  }
}
