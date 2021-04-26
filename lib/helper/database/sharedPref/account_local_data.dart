import 'package:e_commerce/constants.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AccountLocalData {
  Future<void> setUserData(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        PROFILE_LOCAL_DATA_KEY, json.encode(userModel.toJson()));
  }

  Future<UserModel> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String data =  sharedPreferences.getString(PROFILE_LOCAL_DATA_KEY);
    return UserModel.fromJson(json.decode(data));
  }
  Future<void> deleteUserData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   await sharedPreferences.clear();
  }

}
