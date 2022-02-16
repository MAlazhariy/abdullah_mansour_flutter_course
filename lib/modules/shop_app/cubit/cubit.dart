import 'package:bloc/bloc.dart';
import 'package:firstapp/models/user/shop_app/shop_app_models.dart';
import 'package:firstapp/modules/shop_app/cubit/states.dart';
import 'package:firstapp/shared/network/end_points.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopAppCubit extends Cubit<ShopAppStates>{
  ShopAppCubit() : super(ShopAppInitState());

  static ShopAppCubit get (context) {
    return BlocProvider.of(context);
  }

  bool showPassword = false;
  String passwordShowHide = 'Show';
  bool changePassColor = false;
  bool changeEmailColor = false;
  TextInputType emailKeyboard = TextInputType.emailAddress;

  String emailCounter = '';

  void changeShowPassword (){
    showPassword = !showPassword;
    passwordShowHide = showPassword ? 'Hide' : 'Show';
    emit(ShopAppChangePasswordVisibility());
  }

  void changeKeyboard({
  bool isUrl = false,
}){
    emailKeyboard = isUrl ? TextInputType.url : TextInputType.emailAddress;
    emit(ShopAppChangeKeyboardType());
  }

  void changeCounter({
    @required bool isEmail,
    @required String title,
}){
    isEmail ? emailCounter=title : null;
    emit(ShopAppChangeCounter());
  }

  void hidePassword (){
    showPassword = false;
    passwordShowHide = 'Show';
    emit(ShopAppChangePasswordVisibility());
  }

  void changeColor({
    @required bool changeColor,
    @required bool isEmail,
  }){
    isEmail ? changeEmailColor=changeColor : changePassColor=changeColor;
    emit(ShopAppChangeColor());
  }



  void signIn ({
    @required String email,
    @required String password,
    String lang = 'ar',
  }) {
    emit(ShopAppLoginLoading());

    DioHelper.postData(
        path: LOGIN,
        data: {
          'email' : email,
          'password' : password,
        },
        lang: lang,

    ).then((value) {
      emit(ShopAppLoginSuccessful(ShopLoginModel(loginData: value.data)));
    }).catchError((error){
      print('--Error during SignIn: ${error.toString()}');
      emit(ShopAppLoginError());
    });
  }



}