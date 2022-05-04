import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/shop_app/login_model.dart';
import 'package:firstapp/modules/shop_app/login/login_cubit/login_states.dart';
import 'package:firstapp/modules/shop_app/register/register_cubit/register_states.dart';
import 'package:firstapp/modules/social_app/social_register/register_cubit/register_states.dart';
import 'package:firstapp/shared/network/end_points.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitState());

  static SocialRegisterCubit get(context) {
    return BlocProvider.of(context);
  }

  bool showPassword = false;
  String passwordShowHide = 'Show';
  bool changePassColor = false;
  bool changeEmailColor = false;

  void changePasswordVisibility() {
    showPassword = !showPassword;
    passwordShowHide = showPassword ? 'Hide' : 'Show';
    emit(SocialRegisterChangePasswordVisibility());
  }

  void hidePassword() {
    showPassword = false;
    passwordShowHide = 'Show';
    emit(SocialRegisterChangePasswordVisibility());
  }

  void changeColor({
    required bool changeColor,
    required bool isEmail,
  }) {
    isEmail ? changeEmailColor = changeColor : changePassColor = changeColor;
    emit(SocialRegisterChangeColor());
  }

  void register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    // loading
    emit(SocialRegisterLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      emit(SocialRegisterSuccessful());
      log(value.user?.uid??'null');
      log(value.user?.email??'null');
    }).catchError((error) {
      log('-- Error when Register: ${error.toString()}');
      emit(SocialRegisterError(error.toString()));
    });
  }
}
