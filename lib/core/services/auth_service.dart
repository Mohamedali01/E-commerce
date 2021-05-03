import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/user_model.dart';

class AuthService {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUsersData(UserModel userModel) async {
    await _collectionReference.doc(userModel.userId).set(userModel.toJson());
  }

  Future<DocumentSnapshot> getUserData(String uid) async {
    DocumentSnapshot data = await _collectionReference.doc(uid).get();
    return data;
  }

  Future<void> updateUserData(UserModel userModel)async{
    await _collectionReference.doc(userModel.userId).update(userModel.toJson());
  }


}
