class UserModel {
  String userId;
  String name;
  String email;
  String pic;

  UserModel({this.userId, this.name, this.email, this.pic});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null)
      return;
    else {
      userId = map['userId'];
      name = map['name'];
      email = map['email'];
      pic = map['pic'];
    }
  }

   toJson() {
    return {'userId': userId, 'name': name, 'email': email, 'pic': pic};
  }
}
