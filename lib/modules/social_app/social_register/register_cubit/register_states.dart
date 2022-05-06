
abstract class SocialRegisterStates {}

class SocialRegisterInitState extends SocialRegisterStates{}
class SocialRegisterChangePasswordVisibility extends SocialRegisterStates{}
class SocialRegisterChangeCounter extends SocialRegisterStates{}
class SocialRegisterChangeColor extends SocialRegisterStates{}
class SocialRegisterChangeKeyboardType extends SocialRegisterStates{}

class SocialRegisterLoading extends SocialRegisterStates{}
class SocialRegisterError extends SocialRegisterStates{
  late String error;
  SocialRegisterError(this.error);
}
class SocialRegisterSuccessful extends SocialRegisterStates {}

class SocialCreateUserError extends SocialRegisterStates{
  late String error;
  SocialCreateUserError(this.error);
}
class SocialCreateUserSuccessful extends SocialRegisterStates {}
