import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  CollectionReference _categoryReference =
      FirebaseFirestore.instance.collection('Categories');
  CollectionReference _bestSellingReference =
      FirebaseFirestore.instance.collection('Products');

  Future<List<QueryDocumentSnapshot>> getCategories() async {
    QuerySnapshot querySnapshot = await _categoryReference.get();
    return querySnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot>> getBestSelling() async {
    QuerySnapshot querySnapshot = await _bestSellingReference.get();
    return querySnapshot.docs;
  }
}
