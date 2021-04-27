import 'package:e_commerce/helper/database/cart_database.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CartViewModel with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<CartModel> _cartProducts = [];
  List<ProductModel> _productModels = [];

  List<CartModel> get cartProducts => _cartProducts;
  CartDatabase database = CartDatabase.db;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  CartViewModel() {
    getAllProducts();
  }

  void clearCartProducts(){
    _cartProducts = [];
    notifyListeners();
  }
  Future<void> insertCartItem(CartModel cartModel) async {
    bool find = false;
    for (int i = 0; i < _cartProducts.length; i++) {
      if (_cartProducts[i].cartId == cartModel.cartId) {
        find = true;
        Fluttertoast.showToast(msg: 'Item already exists in the cart');
        return;
      }
    }
    if (find == false) {
      try {
        _cartProducts.add(cartModel);
        await database.insert(cartModel);
        _totalPrice =
            _totalPrice + (double.parse(cartModel.price) * cartModel.quantity);
        notifyListeners();
        Fluttertoast.showToast(msg: 'Item added to cart successfully!');
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error happened!');
        print('Mohamed Ali insertCartItem error: ${e.toString()}');
        notifyListeners();
      }
      // HomeService homeService = HomeService();
      // await homeService.setCartProducts(cartModel);
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
    await database.clear();
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

  Future<void> removeCartItem(String id) async {
    try {
      int index = _cartProducts.indexWhere((element) => element.cartId == id);
      CartModel cM = _cartProducts[index];
      _cartProducts.removeAt(index);
      _totalPrice = _totalPrice - (double.parse(cM.price) * cM.quantity);
      Fluttertoast.showToast(msg: 'Item removed successfully!');
      notifyListeners();
      // CartDatabase cartDatabase = CartDatabase.db;
      // HomeService homeService = HomeService();
      // await cartDatabase.deleteCartItem(id);
      // // await homeService.deleteCartItem(id);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error happened!');
      notifyListeners();
    }
  }

  void pressItem(String id) {
    ProductModel productModel =
        _productModels.firstWhere((element) => element.productId == id);
    Get.to(
      ProductDetailsView(
        model: productModel,
      ),
    );
  }

  void update(List<ProductModel> list) {
    _productModels = list;
    notifyListeners();
  }
}
