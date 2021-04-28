import 'package:e_commerce/helper/hex_color.dart';
import 'package:flutter/material.dart';

class ProductModel {
  String productId, name, description, image, price, sized,category;
  Color color;

  ProductModel(
      {this.productId,
      this.name,
      this.description,
      this.image,
      this.price,
      this.sized,
      this.color});

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null)
      return;
    else {
      name = map['name'];
      description = map['description'];
      image = map['image'];
      price = map['price'];
      sized = map['sized'];
      color = HexColor.fromHex(map['color']);
      productId = map['productId'];
    }
  }

  toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'sized': sized,
      'color': color,
      'productId': productId
    };
  }
}
