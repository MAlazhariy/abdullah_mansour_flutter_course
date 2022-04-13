import 'package:firstapp/models/shop_app/shop_app_models.dart';

abstract class ShopAppStates {}

class ShopAppInitState extends ShopAppStates{}
class ShopAppChangePasswordVisibility extends ShopAppStates{}
class ShopAppChangeCounter extends ShopAppStates{}
class ShopAppChangeColor extends ShopAppStates{}
class ShopAppChangeKeyboardType extends ShopAppStates{}

class ShopAppLoginLoading extends ShopAppStates{}
class ShopAppLoginError extends ShopAppStates{}
class ShopAppLoginSuccessful extends ShopAppStates {
  final ShopLoginModel loginInfo;
  ShopAppLoginSuccessful(this.loginInfo);
}
