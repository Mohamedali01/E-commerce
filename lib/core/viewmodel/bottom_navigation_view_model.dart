import 'package:e_commerce/view/account_view.dart';
import 'package:e_commerce/view/cart_view.dart';
import 'package:e_commerce/view/home_view.dart';
import 'package:flutter/material.dart';

class BottomNavigationViewModel with ChangeNotifier {
  int _index = 0;
  Widget _currentView = HomeView();

  Widget get currentView => _currentView;

  int get index => _index;

  void changeState(int selectedIndex) {
    _index = selectedIndex;
    switch (index) {
      case 0:
        _currentView = HomeView();
        break;
      case 1:
        _currentView = CartView();
        break;
      case 2:
        _currentView = AccountView();
        break;
    }
    notifyListeners();
  }
}
