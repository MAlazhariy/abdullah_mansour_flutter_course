import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/models/social_app/post_model.dart';
import 'package:firstapp/models/social_app/social_user_model.dart';
import 'package:firstapp/modules/social_app/chats/chats_screen.dart';
import 'package:firstapp/modules/social_app/cubit/states.dart';
import 'package:firstapp/modules/social_app/home/home_screen.dart';
import 'package:firstapp/modules/social_app/settings/settings_screen.dart';
import 'package:firstapp/modules/social_app/settings/update_cover_screen.dart';
import 'package:firstapp/modules/social_app/settings/update_profile_image_screen.dart';
import 'package:firstapp/modules/social_app/users/users_screen.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:firstapp/shared/components/dismiss_keyboard.dart';
import 'package:firstapp/shared/components/push.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  PostModel? postModel;
  int currentIndex = 0;

  final ImagePicker _picker = ImagePicker();

  File? coverImage;
  File? profileImage;
  File? postImage;

  List<GetPostModel> posts = [];

  bool showCommentSendButton = false;

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

  void sendCommentVisibility(String comment) {
    showCommentSendButton = comment.isNotEmpty;
    emit(SocialChangeSendCommentVisibilityState());
  }

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

  Future<void> getCoverImage(BuildContext context) async {
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
          .ref('users/$uId/coverImage')
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

  Future<void> getProfileImage(BuildContext context) async {
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
          .ref('users/$uId/profileImage')
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
    }).catchError((error) {
      log('error when updateBio: ${error.toString()}');
      userModel!.bio = _oldBio;
      emit(SocialUpdateBioErrorState(error.toString()));
    });
  }

  /// create a new post methods
  Future<void> getPostImage() async {
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      postImage = File(value!.path);
      emit(SocialGetPostImageSuccessState());
    }).catchError((error) {
      log('error when getPostImage: ${error.toString()}');
      emit(SocialGetPostImageErrorState(error.toString()));
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageSuccessState());
  }

  Future<void> createPostWithImage({
    required String text,
  }) async {
    emit(SocialCreatePostWithImageLoadingState());

    // upload profileImage to Firestore Storage
    FirebaseStorage.instance
        .ref('users/$uId/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      // get image url
      value.ref.getDownloadURL().then((url) {
        createNewPost(
          text: text,
          postImage: url,
        );
      }).catchError((error) {
        emit(SocialCreatePostWithImageErrorState(error.toString()));
        log('error when getDownloadURL inside createPostWithImage: ${error.toString()}');
      });
    }).catchError((error) {
      emit(SocialCreatePostWithImageErrorState(error.toString()));
      log('error when createPostWithImage: ${error.toString()}');
    });
  }

  Future<void> createNewPost({
    required String text,
    String postImage = '',
  }) async {
    if (postImage.isEmpty) emit(SocialCreatePostLoadingState());

    var now = DateTime.now();

    // create postModel
    postModel = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      userImage: userModel!.image,
      text: text,
      postImage: postImage,
      // january 21, 2021 at 11:00 pm
      dateTime: DateFormat('MMMM dd, yyyy - hh:mm aa')
          .format(now)
          .replaceAll('-', 'at'),
      milSecEpoch: now.millisecondsSinceEpoch,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel!.toMap())
        .then((_) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      log('error when createNewPost: ${error.toString()}');
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  void getPosts() {
    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('milSecEpoch', descending: true)
        .get()
        .then((value) async {
      for (int i = 0; i < value.docs.length; i++) {
        var postDoc = value.docs[i];

        log(postDoc.data()['text']);

        // get likes
        await postDoc.reference
            .collection('likes')
            .where('like', isEqualTo: true)
            .get()
            .then((likeValue) {
          posts.add(
            GetPostModel.fromJson(
              json: postDoc.data(),
              postId: postDoc.id,
              likes: likeValue.docs.map((e) => e.id).toList(),
            ),
          );
        }).catchError((error) {
          log('error when get post likes: ${error.toString()}');
        });

        // get comments
        await postDoc.reference
            .collection('comments')
            .orderBy('milSecEpoch', descending: false)
            .get()
            .then((commentValue) {
          posts[i].comments = [];

          for (var commentDoc in commentValue.docs) {
            posts[i].comments!.add(
                  CommentModel(
                    comment: commentDoc.data()['comment'],
                    uId: commentDoc.data()['uId'],
                    name: commentDoc.data()['name'],
                    userImage: commentDoc.data()['userImage'],
                    milSecEpoch: commentDoc.data()['milSecEpoch'],
                  ),
                );
          }
        }).catchError((error) {
          log('error when get post comments: ${error.toString()}');
        });
      }
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      log('error when getPosts: ${error.toString()}');
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  Future<void> likePost({
    required int postIndex,
  }) async {
    String postId = posts[postIndex].postId;
    bool isLiked = posts[postIndex].likes.contains(userModel!.uId);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': !isLiked,
    }).then((_) {
      if (isLiked) {
        posts[postIndex].likes.remove(userModel!.uId);
      } else {
        posts[postIndex].likes.add(userModel!.uId);
      }

      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      log('error when likePost: ${error.toString()}');
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  Future<void> commentOnPost({
    required String comment,
    required GetPostModel postModel,
  }) async {

    var commentModel = CommentModel(
      comment: comment,
      uId: userModel!.uId,
      name: userModel!.name,
      userImage: userModel!.image,
      milSecEpoch: DateTime.now().millisecondsSinceEpoch,
    );

    // upload comment in Firebase
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postModel.postId)
        .collection('comments')
        .doc()
        .set(commentModel.toMap()).then((_) {
          // add comment to post model
          postModel.comments!.add(commentModel);
          showCommentSendButton = false;
          emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      log('error when commentPost: ${error.toString()}');
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }
}
