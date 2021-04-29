class FavouriteModel {
  String favId, image, name, price;
  bool isFavourite;

  FavouriteModel(
      {this.price, this.image, this.name, this.favId, this.isFavourite});

  FavouriteModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null)
      return;
    else {
      String x = map['isFavourite'];
      name = map['name'];
      price = map['price'];
      image = map['image'];
      favId = map['favId'];
      isFavourite = x.toLowerCase() == 'true';
    }
  }

  toJson() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'favId': favId,
      'isFavourite': isFavourite.toString(),
    };
  }
}
