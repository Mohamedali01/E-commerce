import 'package:e_commerce/model/cart_model.dart';

class Order {
  String userId, dateTime;
  List<CartModel> products;
  Address address;

  Order({this.userId, this.dateTime, this.products, this.address});

  Order.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    userId = map['userId'];
    dateTime = map['dateTime'];
    products = map['products'];
    address = map['address'];
  }

  toJson() {
    return {
      'userId': userId,
      'dateTime': dateTime,
      'products': products,
      'address': address,
    };
  }
}

class Address {
  String street1, street2, city, state, country;

  Address({this.street1, this.street2, this.city, this.state, this.country});

  Address.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    street1 = map['street1'];
    street2 = map['street2'];
    city = map['city'];
    state = map['state'];
    country = map['country'];
  }


  toJson() {
    return {
      'street1': street1,
      'street2': street2,
      'city': city,
      'state': state,
      'country': country,
    };
  }
}
