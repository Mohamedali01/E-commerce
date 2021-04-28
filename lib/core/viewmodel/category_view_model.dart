import 'package:e_commerce/core/services/category_service.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:flutter/material.dart';

class CategoryViewModel with ChangeNotifier {
  List<ProductModel> _men = [];
  List<ProductModel> _gaming = [];
  List<ProductModel> _devices = [];
  List<ProductModel> _women = [];
  List<ProductModel> _gadgets = [];

bool _isLoading = false;

bool get isLoading => _isLoading;
  CategoryViewModel() {
    _getAllData();
  }

  int itemCount(String name) {
    if (name == 'Gaming') return _gaming.length;
    if (name == 'Devices') return _devices.length;
    if (name == 'Gadgets') return _gadgets.length;
    if (name == 'Men') return _men.length;
    if (name == 'Women') return _women.length;
    return 0;
  }

  List<ProductModel> listHandler(String name) {
    if (name == 'Gaming') return _gaming;
    if (name == 'Devices') return _devices;
    if (name == 'Gadgets') return _gadgets;
    if (name == 'Men') return _men;
    if (name == 'Women') return _women;
    return null;
  }

  Future<void> _getAllData() async {
    _isLoading = true;
    notifyListeners();
    CategoryService categoryService = CategoryService();
    _men = await categoryService.getMen();
    _women = await categoryService.getWomen();
    _gaming = await categoryService.getGaming();
    _gadgets = await categoryService.getGadgets();
    _devices = await categoryService.getDevices();
    _isLoading = false;
    notifyListeners();
  }
}
