abstract class SocialStates{}

class SocialInitState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}
class SocialGetUserSuccessState extends SocialStates {}
class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
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