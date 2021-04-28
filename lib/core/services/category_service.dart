import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/product_model.dart';

class CategoryService {
  CollectionReference men = FirebaseFirestore.instance.collection('men');
  CollectionReference women = FirebaseFirestore.instance.collection('Women');
  CollectionReference gaming = FirebaseFirestore.instance.collection('Gaming');
  CollectionReference gadgets =
      FirebaseFirestore.instance.collection('Gadgets');
  CollectionReference devices =
      FirebaseFirestore.instance.collection('Devices');

  Future<List<ProductModel>> getMen() async {
    QuerySnapshot data = await men.get();
    List<QueryDocumentSnapshot> list = data.docs;
    return list.map((e) => ProductModel.fromJson(e.data())).toList();
  }

  Future<List<ProductModel>> getWomen() async {
    final data = await women.get();
    List<QueryDocumentSnapshot> list = data.docs;
    return list.map((e) => ProductModel.fromJson(e.data())).toList();
  }

  Future<List<ProductModel>> getDevices() async {
    final data = await devices.get();
    List<QueryDocumentSnapshot> list = data.docs;

    return list.map((e) => ProductModel.fromJson(e.data())).toList();
  }

  Future<List<ProductModel>> getGadgets() async {
    final data = await gadgets.get();
    List<QueryDocumentSnapshot> list = data.docs;

    return list.map((e) => ProductModel.fromJson(e.data())).toList();
  }

  Future<List<ProductModel>> getGaming() async {
    final data = await gaming.get();
    List<QueryDocumentSnapshot> list = data.docs;
    return list.map((e) => ProductModel.fromJson(e.data())).toList();
  }
}
