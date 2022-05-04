import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/modules/social_app/social_login/login_cubit/login_states.dart';
import 'package:firstapp/shared/network/end_points.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitState());

  static SocialLoginCubit get(context) {
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
    emit(SocialLoginChangePasswordVisibility());
  }

  void hidePassword() {
    showPassword = false;
    passwordShowHide = 'Show';
    emit(SocialLoginChangePasswordVisibility());
  }

  void changeColor({
    required bool changeColor,
    required bool isEmail,
  }) {
    isEmail ? changeEmailColor = changeColor : changePassColor = changeColor;
    emit(SocialLoginChangeColor());
  }

  void signIn({
    required String email,
    required String password,
    String lang = 'ar',
  }) {
    // loading
    emit(SocialLoginLoading());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      emit(SocialLoginSuccessful());
      log(value.user?.uid??'null');
      log(value.user?.email??'null');
    }).catchError((error) {
      log('--Error during SignIn: ${error.toString()}');
      emit(SocialLoginError(error.toString()));
    });
  }
}
