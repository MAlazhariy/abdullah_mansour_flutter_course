import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/models/social_app/social_user_model.dart';
import 'package:firstapp/modules/social_app/chats/chats_screen.dart';
import 'package:firstapp/modules/social_app/cubit/states.dart';
import 'package:firstapp/modules/social_app/home/home_screen.dart';
import 'package:firstapp/modules/social_app/settings/settings_screen.dart';
import 'package:firstapp/modules/social_app/users/users_screen.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitState());

  SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          userModel = SocialUserModel.fromJson(value.data()!);
          // log(userModel.toMap().toString());
          emit(SocialGetUserSuccessState());
    })
        .catchError((error) {
          log('error when getUserData: ${error.toString()}');
          emit(SocialGetUserErrorState(error.toString()));
    });
  }

  void changeNavBar(int index){
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }
}
