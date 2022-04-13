import 'dart:developer';

import 'package:firstapp/models/shop_app/shop_app_models.dart';
import 'package:firstapp/modules/shop_app/login/login_cubit/login_states.dart';
import 'package:firstapp/shared/network/end_points.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitState());

  static ShopLoginCubit get(context) {
    return BlocProvider.of(context);
  }

  bool showPassword = false;
  String passwordShowHide = 'Show';
  bool changePassColor = false;
  bool changeEmailColor = false;
  TextInputType emailKeyboard = TextInputType.emailAddress;

  String emailCounter = '';

  void changeShowPassword() {
    showPassword = !showPassword;
    passwordShowHide = showPassword ? 'Hide' : 'Show';
    emit(ShopLoginChangePasswordVisibility());
  }

  void changeKeyboard({
    bool isUrl = false,
  }) {
    emailKeyboard = isUrl ? TextInputType.url : TextInputType.emailAddress;
    emit(ShopLoginChangeKeyboardType());
  }

  void changeCounter({
    required bool isEmail,
    required String title,
  }) {
    isEmail ? emailCounter = title : null;
    emit(ShopLoginChangeCounter());
  }

  void hidePassword() {
    showPassword = false;
    passwordShowHide = 'Show';
    emit(ShopLoginChangePasswordVisibility());
  }

  void changeColor({
    required bool changeColor,
    required bool isEmail,
  }) {
    isEmail ? changeEmailColor = changeColor : changePassColor = changeColor;
    emit(ShopLoginChangeColor());
  }

  void signIn({
    required String email,
    required String password,
    String lang = 'ar',
  }) {
    // loading
    emit(ShopLoginLoading());

    // post login data
    DioHelper.postData(
      path: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
      lang: lang,
    ).then((value) {
      emit(ShopLoginSuccessful(ShopLoginModel(loginData: value.data)));
    }).catchError((error) {
      log('--Error during SignIn: ${error.toString()}');
      emit(ShopLoginError());
    });
  }
}
