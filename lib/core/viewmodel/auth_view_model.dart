import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/services/auth_service.dart';
import 'package:e_commerce/helper/database/localdata/account_local_data.dart';
import 'package:e_commerce/helper/database/localdata/auth_local_data.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/view/control_View/control_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthViewModel with ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FacebookLogin _facebookLogin = FacebookLogin();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String email, password, name, userId,pic;
  bool _isAdmin = false;

  bool get isAdmin => _isAdmin;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  AuthViewModel() {
    if (_firebaseAuth.currentUser != null) {
      saveDataAfterLogin(_firebaseAuth.currentUser.uid);
    }
  }

  AuthLocalData authLocalData = AuthLocalData();

  Future<void> signInGoogleAuth() async {
    _isLoading = true;
    notifyListeners();
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    _firebaseAuth.signInWithCredential(credential).then(
      (cred) async {
        await saveData(cred);
        _isLoading = false;
        notifyListeners();

        Get.offAll(ControlView());
        await setWhichLogin(AUTH_GOOGLE);
      },
    );
  }

  Future<void> signInFacebookAuth() async {
    _isLoading = true;
    notifyListeners();

    final FacebookLoginResult facebookLoginResult =
        await _facebookLogin.logIn(['email']);
    String accessToken = facebookLoginResult.accessToken.token;
    final OAuthCredential credential =
        FacebookAuthProvider.credential(accessToken);
    await _firebaseAuth.signInWithCredential(credential).then((cred) async {
      await saveData(cred);
      await setWhichLogin(AUTH_FACEBOOK);
      _isLoading = false;
      notifyListeners();

      Get.offAll(ControlView());
    });
  }

  Future<void> signInWithEmailAndPass() async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      //////////////////////
      saveDataAfterLogin(userCredential.user.uid);
      await setWhichLogin(AUTH_EMAIL_AND_PASSWORD);
      _isLoading = false;
      notifyListeners();

      Get.offAll(ControlView());
    } catch (e) {
      print('Mohamed Ali signInWithEmailAndPass error : ${e.toString()}');
      _isLoading = false;
      notifyListeners();
      Get.snackbar('Error!!', 'Invalid authentication',
          backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> createUserWithEmailAndPass() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (cred) async {
          await saveData(cred);
        },
      );
      _isLoading = false;
      notifyListeners();

      await setWhichLogin(AUTH_EMAIL_AND_PASSWORD);
      Get.offAll(ControlView());
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Get.snackbar('Error!!', 'Invalid authentication',
          backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> saveData(UserCredential cred) async {
    UserModel userModel = UserModel(
        email: cred.user.email,
        name: name == null ? cred.user.displayName : name,
        userId: cred.user.uid,
        pic: '',
        isAdmin: _isAdmin);
    AuthService fireStoreService = AuthService();
    await fireStoreService.addUsersData(userModel);
    await saveDataLocal(userModel);
  }

  bool isAuth() {
    User user = _firebaseAuth.currentUser;
    if (user != null)
      return true;
    else
      return false;
  }

  Future<void> autoLogin() async {
    AccountLocalData accountLocalData = AccountLocalData();
    UserModel userModel = await accountLocalData.getUserData();
    email = userModel.email;
    name = userModel.name;
    userId = userModel.userId;
    _isAdmin = userModel.isAdmin;
    notifyListeners();
  }

  Future<void> saveDataLocal(UserModel userModel) async {
    AccountLocalData profileLocalData = AccountLocalData();
    await profileLocalData.setUserData(userModel);
  }

  Future<void> setWhichLogin(String data) async {
    await authLocalData.setWhichLogin(data);
  }

  void saveDataAfterLogin(String uid) async {
    AuthService authService = AuthService();
    DocumentSnapshot documentSnapshot = await authService.getUserData(uid);

    await saveDataLocal(UserModel.fromJson(documentSnapshot.data()));
  }

  void isAdminChanged(bool value){
    _isAdmin = value;
    notifyListeners();
  }
}
