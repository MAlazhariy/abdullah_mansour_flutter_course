
class SocialUserModel {

  late String name;
  late String email;
  late String uId;
  late String phone;
  late bool isEmailVerified;

  SocialUserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.isEmailVerified,
});

  SocialUserModel.fromJson(Map<String, dynamic> json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap(){
    return {
      'email': email,
      'name': name,
      'uId': uId,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
    };
  }

}