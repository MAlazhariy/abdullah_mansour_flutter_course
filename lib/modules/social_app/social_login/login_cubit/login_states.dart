import 'package:firstapp/models/shop_app/login_model.dart';

abstract class SocialLoginStates {}

class SocialLoginInitState extends SocialLoginStates{}
class SocialLoginChangePasswordVisibility extends SocialLoginStates{}
class SocialLoginChangeCounter extends SocialLoginStates{}
class SocialLoginChangeColor extends SocialLoginStates{}
class SocialLoginChangeKeyboardType extends SocialLoginStates{}

class SocialLoginLoading extends SocialLoginStates{}
class SocialLoginError extends SocialLoginStates{
  late final String error;
  SocialLoginError(this.error);
}
class SocialLoginSuccessful extends SocialLoginStates {}
