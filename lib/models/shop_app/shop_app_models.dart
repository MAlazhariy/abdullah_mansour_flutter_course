
class ShopLoginModel {
  late bool status;
  late String message;
  LoginUserData? data;

  ShopLoginModel({
    required Map<String, dynamic> loginData,
  }) {
    status = loginData['status'];
    message = loginData['message'];
    data = loginData['data'] != null
        ? LoginUserData.fromJson(json: loginData['data'])
        : null;
  }
}


class LoginUserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  // named constructor
  LoginUserData.fromJson({
    required Map<String, dynamic> json,
  }) {
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
