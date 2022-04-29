import 'package:firstapp/models/shop_app/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitState extends ShopRegisterStates{}
class ShopRegisterChangePasswordVisibility extends ShopRegisterStates{}
class ShopRegisterChangeCounter extends ShopRegisterStates{}
class ShopRegisterChangeColor extends ShopRegisterStates{}
class ShopRegisterChangeKeyboardType extends ShopRegisterStates{}

class ShopRegisterLoading extends ShopRegisterStates{}
class ShopRegisterError extends ShopRegisterStates{}
class ShopRegisterSuccessful extends ShopRegisterStates {
  final ShopLoginModel loginInfo;
  ShopRegisterSuccessful(this.loginInfo);
}
