abstract class SocialStates{}

class SocialInitState extends SocialStates {}

class SocialChangeSendCommentVisibilityState extends SocialStates {}

/// get user data
class SocialGetUserLoadingState extends SocialStates {}
class SocialGetUserSuccessState extends SocialStates {}
class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

// get posts
class SocialGetPostsLoadingState extends SocialStates {}
class SocialGetPostsSuccessState extends SocialStates {}
class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

/// update cover image states
class SocialUpdateCoverSuccessState extends SocialStates {}
class SocialUpdateCoverErrorState extends SocialStates {
  final String error;

  SocialUpdateCoverErrorState(this.error);
}

class SocialUploadCoverLoadingState extends SocialStates {}
class SocialUploadCoverSuccessState extends SocialStates {}
class SocialUploadCoverErrorState extends SocialStates {
  final String error;

  SocialUploadCoverErrorState(this.error);
}

class SocialUpdateFireStoreCoverLoadingState extends SocialStates {}
class SocialUpdateFireStoreCoverSuccessState extends SocialStates {}
class SocialUpdateFireStoreCoverErrorState extends SocialStates {
  final String error;

  SocialUpdateFireStoreCoverErrorState(this.error);
}


/// update profile image states
class SocialUpdateProfileImageSuccessState extends SocialStates {}
class SocialUpdateProfileImageErrorState extends SocialStates {
  final String error;

  SocialUpdateProfileImageErrorState(this.error);
}

class SocialUploadProfileImageLoadingState extends SocialStates {}
class SocialUploadProfileImageSuccessState extends SocialStates {}
class SocialUploadProfileImageErrorState extends SocialStates {
  final String error;

  SocialUploadProfileImageErrorState(this.error);
}

class SocialUpdateFireStoreProfileImageLoadingState extends SocialStates {}
class SocialUpdateFireStoreProfileImageSuccessState extends SocialStates {}
class SocialUpdateFireStoreProfileImageErrorState extends SocialStates {
  final String error;

  SocialUpdateFireStoreProfileImageErrorState(this.error);
}

/// update bio
class SocialUpdateBioLoadingState extends SocialStates {}
class SocialUpdateBioSuccessState extends SocialStates {}
class SocialUpdateBioErrorState extends SocialStates {
  final String error;

  SocialUpdateBioErrorState(this.error);
}

/// create a new post
class SocialRemovePostImageSuccessState extends SocialStates {}

class SocialGetPostImageLoadingState extends SocialStates {}
class SocialGetPostImageSuccessState extends SocialStates {}
class SocialGetPostImageErrorState extends SocialStates {
  final String error;

  SocialGetPostImageErrorState(this.error);
}

class SocialCreatePostLoadingState extends SocialStates {}
class SocialCreatePostSuccessState extends SocialStates {}
class SocialCreatePostErrorState extends SocialStates {
  final String error;

  SocialCreatePostErrorState(this.error);
}

class SocialCreatePostWithImageLoadingState extends SocialStates {}
class SocialCreatePostWithImageErrorState extends SocialStates {
  final String error;

  SocialCreatePostWithImageErrorState(this.error);
}


/// like post
class SocialLikePostSuccessState extends SocialStates {}
class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

/// comment on a post
class SocialCommentPostSuccessState extends SocialStates {}
class SocialCommentPostErrorState extends SocialStates {
  final String error;

  SocialCommentPostErrorState(this.error);
}