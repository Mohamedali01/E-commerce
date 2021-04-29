import 'package:e_commerce/helper/database/favourites_database.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:e_commerce/model/favourite_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FavouritesViewModel with ChangeNotifier {
  List<FavouriteModel> _favourites = [];

  List<FavouriteModel> get favourites => _favourites;
  List<ProductModel> _productModels = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  FavouritesViewModel() {
    getFavourites();
  }

  void pressItem(String id) {
    ProductModel productModel =
        _productModels.firstWhere((element) => element.productId == id);
    Get.to(ProductDetailsView(model: productModel));
  }

  Future<void> addFavourite(FavouriteModel favouriteModel) async {
    bool find = false;
    for (int i = 0; i < _favourites.length; i++) {
      if (favouriteModel.favId == _favourites[i].favId) {
        find = true;
        Fluttertoast.showToast(msg: 'Item already exists in  favourites!');
        notifyListeners();
      }
    }
    if (find == false) {
      try {
        _favourites.add(favouriteModel);
        notifyListeners();
        Fluttertoast.showToast(msg: 'Item added successfully!');
        FavouritesDatabase favouritesDatabase =
            FavouritesDatabase.favouritesDatabase;
        await favouritesDatabase.insert(favouriteModel);
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error happened!');
        _favourites.removeAt(_favourites.length - 1);
        notifyListeners();
        print('Mohamed Ali: addFavourite error: ${e.toString()}');
      }
    }
  }

  Future<void> removeFavourite(String id) async {
    int index = _favourites.indexWhere((element) => element.favId == id);
    try {
      _favourites[index].isFavourite = false;
      notifyListeners();
      _favourites.removeAt(index);
      notifyListeners();
      FavouritesDatabase favouritesDatabase =
          FavouritesDatabase.favouritesDatabase;
      await favouritesDatabase.delete(id);
      Fluttertoast.showToast(msg: 'Item removed successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error happened!');
      notifyListeners();
    }
  }

  Future<void> getFavourites() async {
    _isLoading = true;
    notifyListeners();
    FavouritesDatabase favouritesDatabase =
        FavouritesDatabase.favouritesDatabase;
    List<FavouriteModel> list = await favouritesDatabase.query();
    _favourites = list;
    _isLoading = false;
    notifyListeners();
  }

  // in productDetailsView
  Future<void> handleFavouriteButton(ProductModel productModel) async {
    bool find = false;
    for (int i = 0; i < _favourites.length; i++) {
      if (_favourites[i].favId == productModel.productId) {
        find = true;
        break;
      }
    }
    if (find == false) {
      await addFavourite(FavouriteModel(
          name: productModel.name,
          isFavourite: true,
          favId: productModel.productId,
          price: productModel.price,
          image: productModel.image));
    } else {
      await removeFavourite(productModel.productId);
    }
  }

  Future<void> clearFavourites() async {
    _favourites = [];
    notifyListeners();
    FavouritesDatabase favouritesDatabase =
        FavouritesDatabase.favouritesDatabase;
    await favouritesDatabase.clear();
  }

  void update(List<ProductModel> list) {
    _productModels = list;
    notifyListeners();
  }

  bool getFavourite(String id) {
    bool find = false;
    for (int i = 0; i < _favourites.length; i++) {
      if (_favourites[i].favId == id) {
        find = true;
        break;
      }
    }
    if (find)
      return true;
    else
      return false;
  }
}
