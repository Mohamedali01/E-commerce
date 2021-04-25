class UserModel {
  String userId;
  String name;
  String email;
  String pic;
  bool isAdmin;

  UserModel({this.userId, this.name, this.email, this.pic, this.isAdmin});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null)
      return;
    else {
      userId = map['userId'];
      name = map['name'];
      email = map['email'];
      pic = map['pic'];
      isAdmin = map['isAdmin'];
    }
  }

  toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'pic': pic,
      'isAdmin': isAdmin
    };
  }
}
