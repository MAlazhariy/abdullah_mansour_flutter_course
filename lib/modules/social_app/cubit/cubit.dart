import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/models/social_app/social_user_model.dart';
import 'package:firstapp/modules/social_app/chats/chats_screen.dart';
import 'package:firstapp/modules/social_app/cubit/states.dart';
import 'package:firstapp/modules/social_app/home/home_screen.dart';
import 'package:firstapp/modules/social_app/settings/settings_screen.dart';
import 'package:firstapp/modules/social_app/settings/update_cover_screen.dart';
import 'package:firstapp/modules/social_app/settings/update_profile_image_screen.dart';
import 'package:firstapp/modules/social_app/users/users_screen.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:firstapp/shared/components/push.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  int currentIndex = 0;

  File? coverImage;
  File? profileImage;

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

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      // log(userModel.toMap().toString());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      log('error when getUserData: ${error.toString()}');
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  void changeNavBar(int index) {
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> updateCoverImage(BuildContext context) async {
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      coverImage = File(value!.path);
      emit(SocialUpdateCoverSuccessState());
      push(
        context,
        const UpdateCoverScreen(),
      );
    }).catchError((error) {
      log('error when updateCoverImage: ${error.toString()}');
      emit(SocialUpdateCoverErrorState(error.toString()));
    });
  }

  Future<void> uploadCoverImage() async {
    if (coverImage != null) {
      emit(SocialUploadCoverLoadingState());

      // upload coverImage to Firestore Storage
      FirebaseStorage.instance
          .ref(
              'users/$uId/coverImage')
          .putFile(coverImage!)
          .then((value) {
        // get cover url
        value.ref.getDownloadURL().then((coverUrl) {
          // update in model
          userModel!.cover = coverUrl;

          // update in Firebase user data
          // emit(SocialUpdateFireStoreCoverLoadingState());

          FirebaseFirestore.instance
              .collection('users')
              .doc(uId)
              .update(userModel!.toMap())
              .then((_) {
            emit(SocialUpdateFireStoreCoverSuccessState());
          }).catchError((error) {
            log('error when uploadCoverImage: ${error.toString()}');
            emit(SocialUpdateFireStoreCoverErrorState(error.toString()));
          });
        }).catchError((error) {
          log('error when getDownloadURL inside uploadCoverImage: ${error.toString()}');
        });
      }).catchError((error) {
        log('error when uploadCoverImage: ${error.toString()}');
        emit(SocialUploadCoverErrorState(error.toString()));
      });
    } else {
      log('coverImage is NULL !');
    }
  }

  Future<void> updateProfileImage(BuildContext context) async {
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      profileImage = File(value!.path);
      emit(SocialUpdateProfileImageSuccessState());
      push(
        context,
        const UpdateProfileImageScreen(),
      );
    }).catchError((error) {
      log('error when updateProfileImage: ${error.toString()}');
      emit(SocialUpdateProfileImageErrorState(error.toString()));
    });
  }

  Future<void> uploadProfileImage() async {
    if (profileImage != null) {
      emit(SocialUploadProfileImageLoadingState());

      // upload profileImage to Firestore Storage
      FirebaseStorage.instance
          .ref(
              'users/$uId/profileImage')
          .putFile(profileImage!)
          .then((value) {
        // get cover url
        value.ref.getDownloadURL().then((profileUrl) {
          // update in model
          userModel!.image = profileUrl;

          // update in Firebase user data
          // emit(SocialUpdateFireStoreProfileImageLoadingState());

          FirebaseFirestore.instance
              .collection('users')
              .doc(uId)
              .update(userModel!.toMap())
              .then((_) {
            emit(SocialUpdateFireStoreProfileImageSuccessState());
          }).catchError((error) {
            log('error when uploadProfileImage: ${error.toString()}');
            emit(SocialUpdateFireStoreProfileImageErrorState(error.toString()));
          });
        }).catchError((error) {
          log('error when getDownloadURL inside uploadProfileImage: ${error.toString()}');
        });
      }).catchError((error) {
        log('error when uploadProfileImageImage: ${error.toString()}');
        emit(SocialUploadProfileImageErrorState(error.toString()));
      });
    } else {
      log('profileImage is NULL !');
    }
  }

  Future<void> updateBio(String bio) async {
    emit(SocialUpdateBioLoadingState());

    final String _oldBio = userModel!.bio;

    // update bio in userModel
    userModel!.bio = bio;

    // update bio in Firebase
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(userModel!.toMap())
        .then((value) {
          emit(SocialUpdateBioSuccessState());
    })
        .catchError((error) {
      log('error when updateBio: ${error.toString()}');
      userModel!.bio = _oldBio;
      emit(SocialUpdateBioErrorState(error.toString()));
    });
  }
}
