class ShopLoginModel {
  late bool status;
  // Could be null
  late String? message;
  LoginUserData? data;

  ShopLoginModel(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? LoginUserData.fromJson(json['data'])
        : null;
  }

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = LoginUserData.fromJson(json['data']);
    }
  }
}

class LoginUserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;
  late int? points;
  late int? credit;

  // named constructor
  LoginUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
