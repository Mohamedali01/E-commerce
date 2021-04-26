import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/services/home_service.dart';
import 'package:e_commerce/model/category_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  List<CategoryModel> _categoryModels = [];
  List<ProductModel> _productModels = [];
  ValueNotifier<bool> _isLoading = ValueNotifier(false);

  ValueNotifier<bool> get isLoading => _isLoading;

  List<CategoryModel> get categoryModels => _categoryModels;

  List<ProductModel> get productModels => _productModels;

  HomeViewModel() {
    getCategories();
    getBestSelling();
  }

  getCategories() async {
    _isLoading.value = true;
    List<QueryDocumentSnapshot> a = await HomeService().getCategories();
    List<CategoryModel> test = [];
    a.forEach((element) {
      test.add(CategoryModel.fromJson(element.data()));
    });
    _categoryModels = test.reversed.toList();
    _isLoading.value = false;
    notifyListeners();
  }

  getBestSelling() async {
    _isLoading.value = true;
    notifyListeners();
    List<QueryDocumentSnapshot> list = await HomeService().getBestSelling();
    List<ProductModel> l = list
        .map((element) => ProductModel.fromJson(element.data()))
        .toList();
    _productModels = l;
    _isLoading.value = false;
    notifyListeners();
  }
}
