import 'dart:developer';

import 'package:firstapp/models/social_app/message_model.dart';
import 'package:firstapp/models/social_app/post_model.dart';
import 'package:firstapp/models/social_app/social_user_model.dart';
import 'package:firstapp/modules/social_app/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/cubit/states.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:firstapp/shared/components/dismiss_keyboard.dart';
import 'package:firstapp/shared/styles/icon_broken.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({
    required this.theUser,
    Key? key,
  }) : super(key: key);

  final SocialUserModel theUser;

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();

    if(!SocialCubit.get(context).chats.containsKey(theUser.uId)){
      SocialCubit.get(context).chats.putIfAbsent(theUser.uId, () => []);
    }

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                // user image
                Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        theUser.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 11),
                // name and bio
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name
                      Row(
                        children: [
                          Text(
                            theUser.name,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 3),
                          if (theUser.name == 'Mostafa Alazhariy')
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blueAccent,
                              size: 14.5,
                            ),
                        ],
                      ),
                      // bio
                      Text(
                        theUser.bio,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 11),
              ],
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left,
              ),
            ),
            elevation: 2,
            shadowColor: Colors.grey[200],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // messages ui
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          if (cubit.chats.containsKey(theUser.uId)) {
                            return messageBuilder(cubit.chats[theUser.uId]![index]);
                          }
                          return const SizedBox();
                        },
                        itemCount: cubit.chats[theUser.uId]?.length ??0,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        reverse: false,
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),

              // Divider
              Container(
                height: 0.8,
                width: double.maxFinite,
                color: Colors.grey[300],
                margin: const EdgeInsets.symmetric(
                  vertical: 9,
                ),
              ),

              // send message
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      minLines: 1,
                      maxLines: 3,
                      onChanged: (value) {
                        cubit.sendCommentVisibility(value.trim());
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write a message ..',
                      ),
                    ),
                  ),
                  // send button
                  if (cubit.showCommentSendButton)
                    MaterialButton(
                      onPressed: () {
                        // todo: handle send message method

                        var now = DateTime.now();
                        String dateTime = DateFormat('MMMM dd, yyyy - hh:mm aa')
                            .format(now)
                            .replaceAll('-', 'at');

                        var _mModel = MessageModel(
                          dateTime: dateTime,
                          receiverId: theUser.uId,
                          senderId: uId,
                          message: messageController.text.trim(),
                          milSecEpoch: now.millisecondsSinceEpoch,
                        );

                        cubit.sendMessage(
                          messageModel: _mModel,
                          userId: theUser.uId,
                        );

                        messageController.text = '';

                        // cubit
                        //     .commentOnPost(
                        //   comment: messageController.text.trim(),
                        //   postModel: postModel,
                        // )
                        //     .then((value) {
                        //   messageController.text = '';
                        // });
                      },
                      padding: const EdgeInsets.all(8),
                      minWidth: 0,
                      color: Colors.blueAccent,
                      shape: const CircleBorder(),
                      child: const Icon(
                        IconBroken.Send,
                        color: Colors.white,
                        size: 23,
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget messageBuilder(MessageModel model) {
    if (model.senderId == uId) {
      return sentMessageBuilder(model);
    }
    return receivedMessageBuilder(model);
  }

  Widget sentMessageBuilder(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.shade200,
          borderRadius: const BorderRadiusDirectional.only(
            // bottomEnd: Radius.circular(8),
            bottomStart: Radius.circular(11),
            topEnd: Radius.circular(11),
            topStart: Radius.circular(11),
          ),
        ),
        margin: const EdgeInsetsDirectional.only(
          top: 5,
          bottom: 5,
          start: 55,
          end: 10,
        ),
        padding: const EdgeInsetsDirectional.only(
          top: 11,
          bottom: 5,
          start: 15,
          end: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // message
            Text(
              model.message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            // time
            Text(
              model.dateTime,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget receivedMessageBuilder(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(11),
            // bottomStart: Radius.circular(11),
            topEnd: Radius.circular(11),
            topStart: Radius.circular(11),
          ),
        ),
        margin: const EdgeInsetsDirectional.only(
          top: 5,
          bottom: 5,
          start: 10,
          end: 55,
        ),
        padding: const EdgeInsetsDirectional.only(
          top: 11,
          bottom: 5,
          start: 15,
          end: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // message
            Text(
              model.message,
            ),
            const SizedBox(height: 5),
            Text(
              model.dateTime,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
