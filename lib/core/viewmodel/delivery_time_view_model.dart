import 'package:e_commerce/enums.dart';
import 'package:flutter/material.dart';

class DeliveryTimeViewModel with ChangeNotifier {
  Delivery delivery;
  void changeDelivery(Delivery value) {
    delivery = value;
    notifyListeners();
  }
}
