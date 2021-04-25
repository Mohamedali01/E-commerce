import 'package:e_commerce/helper/database/cart_database.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:flutter/material.dart';

class CartViewModel with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<CartModel> _cartProducts = [];

  List<CartModel> _favourites = [];



  void addFavourite(CartModel cartModel) {
    _favourites.add(cartModel);
    notifyListeners();
  }

  void removeFavourite(String id) {
    _favourites.removeWhere((element) => element.cartId == id);
    notifyListeners();
  }
  List<CartModel> get favourites =>_favourites;
  List<CartModel> get cartProducts => _cartProducts;
  CartDatabase database = CartDatabase.db;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  CartViewModel() {
    getAllProducts();
  }

  Future<void> insertCartItem(CartModel cartModel) async {
    bool find = false;
    for (int i = 0; i < _cartProducts.length; i++) {
      if (_cartProducts[i].cartId == cartModel.cartId) {
        find = true;
        return;
      }
    }
    if (find == false) {
      _cartProducts.add(cartModel);
      await database.insert(cartModel);
      _totalPrice =
          _totalPrice + (double.parse(cartModel.price) * cartModel.quantity);
      notifyListeners();
    }
  }

  Future<void> getAllProducts() async {
    _isLoading = true;
    notifyListeners();
    List<CartModel> list = await database.getAllCartProducts();
    _cartProducts = list;
    _isLoading = false;
    getTotalPrice();
    notifyListeners();
  }

  Future<void> deleteCartProducts() async {
    await database.deleteAllCartProducts();
    _cartProducts = [];
    notifyListeners();
  }

  Future<void> incrementQuantity(int index) async {
    _cartProducts[index].quantity++;
    await database.update(_cartProducts[index]);
    _totalPrice = _totalPrice + (double.parse(_cartProducts[index].price));

    notifyListeners();
  }

  Future<void> decrementQuantity(int index) async {
    if (_cartProducts[index].quantity > 0) {
      _cartProducts[index].quantity--;
      await database.update(_cartProducts[index]);
      _totalPrice = _totalPrice - (double.parse(_cartProducts[index].price));

      notifyListeners();
    }
  }

  void getTotalPrice() {
    _cartProducts.forEach((element) {
      _totalPrice =
          _totalPrice + (double.parse(element.price) * element.quantity);
    });
    notifyListeners();
  }

  void removeCartItem(String id) {
    _cartProducts.removeWhere((element) => element.cartId == id);
    notifyListeners();
  }
}
