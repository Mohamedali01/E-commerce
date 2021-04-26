import 'package:e_commerce/core/services/home_service.dart';
import 'package:e_commerce/helper/database/favourites_database.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FavouritesViewModel with ChangeNotifier {
  List<CartModel> _favourites = [];

  List<CartModel> get favourites => _favourites;
  List<ProductModel> _productModels = [];
  bool _isLoading;

  bool get isLoading => _isLoading;

  FavouritesViewModel() {
    getFavourites();
  }

  void pressItem(String id) {
    ProductModel productModel =
        _productModels.firstWhere((element) => element.productId == id);
    Get.to(ProductDetailsView(model: productModel));
  }

  Future<void> addFavourite(CartModel cartModel) async {
    bool find = false;
    for (int i = 0; i < _favourites.length; i++) {
      if (cartModel.cartId == _favourites[i].cartId) {
        find = true;
        Fluttertoast.showToast(msg: 'Item already exists in  favourites!');
        notifyListeners();
      }
    }
    if (find == false) {
      try {
        _favourites.add(cartModel);
        notifyListeners();
        Fluttertoast.showToast(msg: 'Item added successfully!');
        FavouritesDatabase favouritesDatabase =
            FavouritesDatabase.favouritesDatabase;
        await favouritesDatabase.insert(cartModel);
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error happened!');
        _favourites.removeAt(_favourites.length - 1);
        notifyListeners();
        print('Mohamed Ali: addFavourite error: ${e.toString()}');
      }
    }
  }

  Future<void> removeFavourite(String id) async {
    int index = _favourites.indexWhere((element) => element.cartId == id);
    CartModel cartModel = _favourites[index];
    try {
      _favourites.removeAt(index);
      notifyListeners();
      FavouritesDatabase favouritesDatabase =
          FavouritesDatabase.favouritesDatabase;
      await favouritesDatabase.delete(id);
      HomeService homeService = HomeService();
      await favouritesDatabase.delete(id);
      // await homeService.deleteFavouriteItem(id);

      Fluttertoast.showToast(msg: 'Item removed successfully');

    } catch (e) {
      Fluttertoast.showToast(msg: 'Error happened!');
      _favourites.insert(index, cartModel);
      notifyListeners();
    }
  }

  Future<void> getFavourites() async {
    _isLoading = true;
    notifyListeners();
    FavouritesDatabase favouritesDatabase =
        FavouritesDatabase.favouritesDatabase;
    List<CartModel> list = await favouritesDatabase.query();
    _favourites = list;
    _isLoading = false;
    notifyListeners();
  }

  void update(List<ProductModel> list) {
    _productModels = list;
    notifyListeners();
  }
}
