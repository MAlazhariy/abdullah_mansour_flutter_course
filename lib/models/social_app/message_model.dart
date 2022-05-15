
// import 'dart:developer';
//
// class ChatModel {
//
//   late String receiverId;
//   late List<MessageModel>? messages;
//
//   ChatModel({
//     required this.receiverId,
//     this.messages,
//   });
//   {
//     if(newMessage != null && messages != null){
//       log('messages != null: $messages');
//       messages!.add(newMessage);
//     } else if (newMessage != null && messages == null){
//       log('messages = $messages');
//       messages = [newMessage];
//     }
//   }
//
//   // ChatModel.fromJson(Map<String, dynamic> json){
//   //   receiverId = json['receiverId'];
//   //   messages = json['messages'];
//   // }
//
// }


class MessageModel {

  late String dateTime;
  late String receiverId;
  late String senderId;
  late String message;
  late int milSecEpoch;

  MessageModel({
    required this.dateTime,
    required this.receiverId,
    required this.senderId,
    required this.message,
    required this.milSecEpoch,
  });

  MessageModel.fromJson(Map<String, dynamic> json){
    dateTime = json['dateTime'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    message = json['message'];
    milSecEpoch = json['milSecEpoch'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'receiverId': receiverId,
      'senderId': senderId,
      'message': message,
      'milSecEpoch': milSecEpoch,
    };
  }

}