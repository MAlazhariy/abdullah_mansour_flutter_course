import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/models/social_app/social_user_model.dart';
import 'package:firstapp/modules/social_app/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/social_register/register_cubit/register_states.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
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
    required BuildContext context,
  }) {
    // loading
    emit(SocialRegisterLoading());

    // create user in Firebase Auth with email and password
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {

      createUser(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
        context: context,
      );

    }).catchError((error) {
      log('-- Error when Register: ${error.toString()}');
      emit(SocialRegisterError(error.toString()));
    });
  }

  void createUser({
    required String email,
    required String name,
    required String phone,
    required String uId,
    required BuildContext context,
  }) {
    var userModel = SocialUserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      image: 'https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?w=740&t=st=1652066539~exp=1652067139~hmac=56c240665794b1798237d08ee1bdf76558858e666f86e98d001747b6ec5b1461',
      cover: 'https://img.freepik.com/free-vector/hand-drawn-psychedelic-colorful-background_23-2149075812.jpg?w=900&t=st=1652084208~exp=1652084808~hmac=39bc5b885407fed98b7f70b82e221e00a6d31dd531d892337981a8929f74681c',
      bio: '',
      isEmailVerified: false,
    );

    // save uid in cache
    CacheHelper.setSocialUId(uId);

    // save uid in global var
    uId = uId;
    SocialCubit.get(context).userModel = SocialUserModel.fromJson(userModel.toMap());

    // save user model in cache
    CacheHelper.setUserModel(userModel.toMap());

    // create new doc in Firestore
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((_) {
      emit(SocialCreateUserSuccessful());
    }).catchError((error) {
      log('-- Error when createUser: ${error.toString()}');
      emit(SocialRegisterError(error.toString()));
    });
  }
}
