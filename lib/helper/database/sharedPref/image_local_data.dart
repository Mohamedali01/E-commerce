import 'package:shared_preferences/shared_preferences.dart';

class ImageLocalData {
  Future<void> setImageAsBase64(String base64) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('image', base64);
  }

  Future<String> getImageAsBase64() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String base64 = sharedPreferences.getString('image');
    return base64;
  }
}
