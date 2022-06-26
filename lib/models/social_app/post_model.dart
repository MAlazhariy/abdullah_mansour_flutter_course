import 'package:firstapp/models/social_app/comment_model.dart';

class PostModel {

  late String uId;
  late String name;
  late String userImage;

  // post attributes
  late String text;
  late String postImage;
  late String dateTime;
  late int milSecEpoch;

  PostModel({
    required this.name,
    required this.uId,
    required this.userImage,
    required this.text,
    required this.postImage,
    required this.dateTime,
    required this.milSecEpoch,
  });

  PostModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    uId = json['uId'];
    userImage = json['userImage'];
    text = json['text'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    milSecEpoch = json['milSecEpoch'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'userImage': userImage,
      'text': text,
      'postImage': postImage,
      'dateTime': dateTime,
      'milSecEpoch': milSecEpoch,
    };
  }

}

class GetPostModel extends PostModel {
  final String postId;

  /// contains uIds of users who liked the post
  List<String> likes = [];

  List<CommentModel>? comments;


  GetPostModel({
    required String name,
    required String uId,
    required String userImage,
    required String text,
    required String postImage,
    required String dateTime,
    required int milSecEpoch,
    required this.postId,
    required this.likes,
    this.comments,
  }): super(
    name: name,
    uId: uId,
    userImage: userImage,
    text: text,
    postImage: postImage,
    dateTime: dateTime,
    milSecEpoch: milSecEpoch,
  );

  GetPostModel.fromJson({
    required Map<String, dynamic> json,
    required this.postId,
    required this.likes,
    this.comments,
  }) : super.fromJson(json);

}