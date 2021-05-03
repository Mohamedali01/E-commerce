import 'dart:async';

import 'package:e_commerce/constants.dart';
import 'package:e_commerce/helper/database/cart_database.dart';
import 'package:e_commerce/helper/database/favourites_database.dart';
import 'package:e_commerce/helper/database/sharedPref/account_local_data.dart';
import 'package:e_commerce/helper/database/sharedPref/auth_local_data.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/view/auth/login_view.dart';
import 'package:e_commerce/view/control_View/control_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      _isLoading = true;
      notifyListeners();
      FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      String whichLogIn = await getWhichLogin();
      await _authLocalData.deleteWhichLogin();
      AccountLocalData profileLocalData = AccountLocalData();
      await profileLocalData.deleteUserData();
      print('Mohamed Ali userData deleted');
      CartDatabase cartDatabase = CartDatabase.db;
      await cartDatabase.clear();
      print('Mohamed Ali cart data deleted');
      FavouritesDatabase favouritesDatabase =
          FavouritesDatabase.favouritesDatabase;
      await favouritesDatabase.clear();
      print('Mohamed Ali favourite data deleted');
      notifyListeners();
      await cartProvider1.clearCartProducts();
      await favProvider1.clearFavourites();
      if (whichLogIn == AUTH_GOOGLE) await GoogleSignIn().signOut();
      print('Mohamed Ali google');
      if (whichLogIn == AUTH_FACEBOOK) await FacebookLogin().logOut();
      print('Mohamed Ali facebook');
      await _firebaseAuth.signOut();
      print('Mohamed Ali sign out successfully');
      _isLoading = false;
      notifyListeners();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      notifyListeners();
      Get.offAll(LoginView());
    } catch (e) {
      Get.snackbar('Error!', 'Error happened',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      print('Mohamed Ali Error in sign out: ${e.toString()}');
    }
  }
}
