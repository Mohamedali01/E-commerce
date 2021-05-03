import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/services/auth_service.dart';
import 'package:e_commerce/helper/database/sharedPref/account_local_data.dart';
import 'package:e_commerce/helper/database/sharedPref/auth_local_data.dart';
import 'package:e_commerce/helper/database/sharedPref/image_local_data.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/view/control_View/control_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel with ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FacebookLogin _facebookLogin = FacebookLogin();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String email, password, name, userId, pic;
  bool _isAdmin = false;

  final picker = ImagePicker();

  File _image;

  File get image => _image;

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
        // await getCartsData();
        // await getFavouritesData();
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
      // await getCartsData();
      // await getFavouritesData();

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
      // await getCartsData();
      // await getFavouritesData();

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
      // await getCartsData();
      // await getFavouritesData();
      _isLoading = false;
      notifyListeners();
      await setWhichLogin(AUTH_EMAIL_AND_PASSWORD);
      Get.offAll(ControlView());
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print(
          'Mohamed Ali createUserWithEmailAndPassword error: ${e.toString()}');
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
    notifyListeners();
  }

//   Future<void> getCartsData()async{
//     HomeService homeService = HomeService();
//   List<QueryDocumentSnapshot> list =await homeService.getCategories();
//  List<CartModel> newList = list.map((e) => CartModel.fromJson(e.data())).toList();
//  CartDatabase cartDatabase = CartDatabase.db;
// for(int i=0;i<newList.length;i++){
// await  cartDatabase.insert(newList[i]);
// notifyListeners();
// }
//   }
  // Future<void> getFavouritesData()async{
  //   // HomeService homeService = HomeService();
  //   // List<QueryDocumentSnapshot> list =await homeService.getFavourites();
  //   List<CartModel> newList = list.map((e) => CartModel.fromJson(e.data())).toList();
  //   FavouritesDatabase favouritesDatabase = FavouritesDatabase.favouritesDatabase;
  //   for(int i=0;i<newList.length;i++){
  //     await  favouritesDatabase.insert(newList[i]);
  //     notifyListeners();
  //   }

  // }

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
    pic = userModel.pic;
    // ImageLocalData imageLocalData = ImageLocalData();
    // String base64 = await imageLocalData.getImageAsBase64();
    // _imageBytes = Base64Decoder().convert(base64);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String path = sharedPreferences.getString('file');
    _image = File(path);
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
    UserModel userModel = UserModel.fromJson(documentSnapshot.data());
    // if (userModel.pic != null) _image = File.fromRawPath(base64Decode(pic));
    name = userModel.name;
    userId = userModel.userId;
    _isAdmin = userModel.isAdmin;
    pic = userModel.pic;
    email = userModel.email;
    notifyListeners();
    await saveDataLocal(userModel);
  }

  void isAdminChanged(bool value) {
    _isAdmin = value;
    notifyListeners();
  }

  Future<void> updateUserName(String newName) async {
    try {
      UserModel userModel = UserModel(
          email: email,
          name: newName,
          userId: userId,
          isAdmin: isAdmin,
          pic: pic);
      _isLoading = true;
      notifyListeners();
      AuthService authService = AuthService();
      await authService.updateUserData(userModel);
      AccountLocalData accountLocalData = AccountLocalData();
      await accountLocalData.updateUserData(userModel);
      name = newName;
      _isLoading = false;
      notifyListeners();
      Get.back();
      Fluttertoast.showToast(msg: 'Name edited successfully');
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Get.back();
      print('Mohamed Ali updateUserName error: ${e.toString()} ');
      Fluttertoast.showToast(msg: 'Error happened!');
    }
  }

  Future<void> updateUserEmail(String newEmail) async {
    try {
      UserModel userModel = UserModel(
          email: newEmail,
          name: name,
          userId: userId,
          isAdmin: isAdmin,
          pic: pic);
      _isLoading = true;
      notifyListeners();
      AuthService authService = AuthService();
      await authService.updateUserData(userModel);
      AccountLocalData accountLocalData = AccountLocalData();
      await accountLocalData.updateUserData(userModel);
      email = newEmail;
      _isLoading = false;
      notifyListeners();
      Get.back();
      Fluttertoast.showToast(msg: 'Email edited successfully');
    } catch (e) {
      print('Mohamed Ali updateUserEmail error: ${e.toString()} ');

      _isLoading = false;
      notifyListeners();
      Get.back();
      Fluttertoast.showToast(msg: 'Error happened!');
    }
  }

  Future<void> updateUserImage(String newEmail) async {
    try {
      UserModel userModel = UserModel(
          email: newEmail,
          name: name,
          userId: userId,
          isAdmin: isAdmin,
          pic: pic);
      _isLoading = true;
      notifyListeners();
      AuthService authService = AuthService();
      await authService.updateUserData(userModel);
      AccountLocalData accountLocalData = AccountLocalData();
      await accountLocalData.updateUserData(userModel);
      email = newEmail;
      _isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: 'Image edited successfully');
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Get.back();
      Fluttertoast.showToast(msg: 'Error happened!');
    }
  }

  Future getImage() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      File croppedImage = await ImageCropper.cropImage(
        sourcePath: file.path,
      );
      _image = croppedImage ?? file;
      notifyListeners();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('file', _image.path);

      // String base64 = base64Encode(newFile.readAsBytesSync());
      // log('base64 = $base64');
      // _imageBytes = base64Decode(base64);
      // log('imageBytes = $_imageBytes');
      // notifyListeners();
      // ImageLocalData imageLocalData = ImageLocalData();
      // await imageLocalData.setImageAsBase64(base64);
      // AuthService authService = AuthService();
      // await authService.updateUserData(UserModel(
      //     name: name,
      //     isAdmin: _isAdmin,
      //     userId: userId,
      //     email: email,
      //     pic: base64));
    } else {
      print('No image selected.');
    }
  }
}
