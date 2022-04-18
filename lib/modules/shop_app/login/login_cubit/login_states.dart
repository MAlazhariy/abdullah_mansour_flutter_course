import 'package:firstapp/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitState extends ShopLoginStates{}
class ShopLoginChangePasswordVisibility extends ShopLoginStates{}
class ShopLoginChangeCounter extends ShopLoginStates{}
class ShopLoginChangeColor extends ShopLoginStates{}
class ShopLoginChangeKeyboardType extends ShopLoginStates{}

class ShopLoginLoading extends ShopLoginStates{}
class ShopLoginError extends ShopLoginStates{}
class ShopLoginSuccessful extends ShopLoginStates {
  final ShopLoginModel loginInfo;
  ShopLoginSuccessful(this.loginInfo);
}
