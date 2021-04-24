import 'package:e_commerce/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalData {
  Future<void> setWhichLogin(String data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(AUTH_LOCAL_DATA_KEY, data);
  }

  Future<String> getWhichLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AUTH_LOCAL_DATA_KEY);
  }
  Future<void> deleteWhichLogin()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   await sharedPreferences.clear();
  }
}
