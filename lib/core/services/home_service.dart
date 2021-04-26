import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/cart_model.dart';

class HomeService {
  CollectionReference _categoryReference =
      FirebaseFirestore.instance.collection('Categories');
  CollectionReference _bestSellingReference =
      FirebaseFirestore.instance.collection('Products');
  CollectionReference _cartProductsReference =
      FirebaseFirestore.instance.collection('Carts');
  CollectionReference _favouritesReference =
      FirebaseFirestore.instance.collection('Favourites');

  Future<List<QueryDocumentSnapshot>> getCategories() async {
    QuerySnapshot querySnapshot = await _categoryReference.get();
    return querySnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot>> getBestSelling() async {
    QuerySnapshot querySnapshot = await _bestSellingReference.get();
    return querySnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot>> getCartProducts() async {
    QuerySnapshot querySnapshot = await _cartProductsReference.get();
    return querySnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot>> getFavourites() async {
    QuerySnapshot querySnapshot = await _favouritesReference.get();
    return querySnapshot.docs;
  }


}
