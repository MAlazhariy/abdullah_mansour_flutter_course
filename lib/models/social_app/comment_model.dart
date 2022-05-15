class CommentModel {

  late String comment;
  late String uId;
  late String name;
  late String userImage;
  late int milSecEpoch;

  CommentModel({
    required this.comment,
    required this.uId,
    required this.name,
    required this.userImage,
    required this.milSecEpoch,
  });

  CommentModel.fromJson(Map<String, dynamic> json){
    comment = json['comment'];
    uId = json['uId'];
    name = json['name'];
    userImage = json['userImage'];
    milSecEpoch = json['milSecEpoch'];
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'uId': uId,
      'name': name,
      'userImage': userImage,
      'milSecEpoch': milSecEpoch,
    };
  }
}