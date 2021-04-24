import 'package:e_commerce/constants.dart';
import 'package:e_commerce/helper/database/localdata/account_local_data.dart';
import 'package:e_commerce/helper/database/localdata/auth_local_data.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/view/auth/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountViewModel with ChangeNotifier {
  UserModel _userModel;

  UserModel get userModel => _userModel;
  AuthLocalData _authLocalData = AuthLocalData();
  bool _isLoading = false;

  AccountViewModel() {
    getUserData();
  }

  bool get isLoading => _isLoading;

  Future<void> getUserData() async {
    _isLoading = true;
    notifyListeners();
    AccountLocalData accountLocalData = AccountLocalData();
    _userModel = await accountLocalData.getUserData();
    _isLoading = false;
    notifyListeners();
  }

  Future<String> getWhichLogin() async {
    String value = await _authLocalData.getWhichLogin();
    return value;
  }

  Future<void> signOut() async {
    try {
      FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      String whichLogIn = await getWhichLogin();
      if (whichLogIn == AUTH_GOOGLE) await GoogleSignIn().signOut();
      if (whichLogIn == AUTH_FACEBOOK) await FacebookLogin().logOut();
      await _firebaseAuth.signOut();
      await _authLocalData.deleteWhichLogin();
      AccountLocalData profileLocalData = AccountLocalData();
      await profileLocalData.deleteUserData();
      Get.offAll(LoginView());
    } catch (e) {
      Get.snackbar('Error!', 'Error happened',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }
}
