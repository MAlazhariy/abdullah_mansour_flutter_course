
class PostModel {

  late String uId;
  late String name;
  late String image;
  // post attributes
  late String text;
  late String postImage;
  late String dateTime;
  late int milSecEpoch;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.text,
    required this.postImage,
    required this.dateTime,
    required this.milSecEpoch,
  });

  PostModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    uId = json['uId'];
    image = json['userImage'];
    text = json['text'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    milSecEpoch = json['milSecEpoch'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'uId': uId,
      'userImage': image,
      'text': text,
      'postImage': postImage,
      'dateTime': dateTime,
      'milSecEpoch': milSecEpoch,
    };
  }

}