class CartModel {
  String cartId, name, image, price;
  int quantity;

  CartModel({this.cartId, this.name, this.image, this.price, this.quantity});

  CartModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null)
      return;
    else {
      name = map['name'];
      image = map['image'];
      price = map['price'];
      quantity = map['quantity'];
      cartId = map['cartId'].toString();
    }
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'cartId': cartId
    };
  }
}
