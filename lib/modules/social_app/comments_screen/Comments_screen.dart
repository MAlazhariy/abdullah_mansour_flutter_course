import 'dart:developer';

import 'package:firstapp/models/social_app/post_model.dart';
import 'package:firstapp/models/social_app/social_user_model.dart';
import 'package:firstapp/modules/social_app/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/cubit/states.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:firstapp/shared/components/dismiss_keyboard.dart';
import 'package:firstapp/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({
    required this.postIndex,
    Key? key,
  }) : super(key: key);

  final int postIndex;

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var postModel = cubit.posts[postIndex];
        var userModel = cubit.userModel!;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Comments',
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left,
              ),
            ),
          ),

          // bottomSheet: Container(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 10,
          //   ),
          //   child: Row(
          //     children: [
          //       // user image
          //       Container(
          //         width: 35,
          //         height: 35,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           image: DecorationImage(
          //             image: NetworkImage(
          //               userModel.image,
          //             ),
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       ),
          //       const SizedBox(width: 11),
          //       // write a comment
          //       Expanded(
          //         child: TextFormField(
          //           controller: commentController,
          //           minLines: 1,
          //           maxLines: 3,
          //           onChanged: (value) {
          //             cubit.sendCommentVisibility(value);
          //           },
          //           keyboardType: TextInputType.multiline,
          //           decoration: const InputDecoration(
          //             border: InputBorder.none,
          //             hintText: 'Write a comment ..',
          //           ),
          //         ),
          //       ),
          //       if (cubit.showCommentSendButton)
          //         MaterialButton(
          //           onPressed: () {
          //             dismissKeyboard(context);
          //
          //             cubit
          //                 .commentOnPost(
          //               comment: commentController.text,
          //               postModel: postModel,
          //             )
          //                 .then((value) {
          //               commentController.text = '';
          //             });
          //           },
          //           padding: const EdgeInsets.symmetric(horizontal: 8),
          //           minWidth: 0,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           child: const Icon(
          //             IconBroken.Send,
          //             color: Colors.blueAccent,
          //             size: 23,
          //           ),
          //         ),
          //     ],
          //   ),
          // ),

          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey[400]!,
                  blurRadius: 3,
                  offset: const Offset(0, 1.5),
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            padding: const EdgeInsetsDirectional.only(
              top: 10,
              start: 15,
              end: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // user details
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // user image
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    postModel.userImage,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 11),
                            // name and date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // name
                                  Row(
                                    children: [
                                      Text(
                                        postModel.name,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      if (postModel.name == 'Mostafa Alazhariy')
                                        const Icon(
                                          Icons.check_circle,
                                          color: Colors.blueAccent,
                                          size: 14.5,
                                        ),
                                    ],
                                  ),
                                  Text(
                                    postModel.dateTime,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 3),
                            // icon more
                            Icon(
                              Icons.more_horiz,
                              color: Colors.grey[600],
                              size: 19,
                            ),
                          ],
                        ),
                        const SizedBox(height: 11),
                        // post content
                        Text(
                          postModel.text,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // post image
                        if (postModel.postImage.isNotEmpty)
                          Container(
                            width: double.maxFinite,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  postModel.postImage,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),

                        const SizedBox(height: 2),

                        // comments and likes number
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                cubit.likePost(postIndex: postIndex);
                              },
                              // padding: EdgeInsets.zero,
                              // minWidth: 0,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              child: Row(
                                children: [
                                  Icon(
                                    postModel.likes.contains(userModel.uId)
                                        ? Icons.favorite
                                        : IconBroken.Heart,
                                    color: Colors.pink,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 3.5),
                                  Text(
                                    postModel.likes.length.toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              IconBroken.Chat,
                              size: 20,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 3.5),
                            Text(
                              '${postModel.comments?.length ?? ''} comments',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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

                        const SizedBox(height: 6),

                        ListView.separated(
                          itemBuilder: (context, index) {
                            return commentBuilder(context, index);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 15);
                          },
                          itemCount: postModel.comments?.length ?? 0,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                        ),

                        // Expanded(
                        //   child: postModel.comments?.isNotEmpty ?? false
                        //       ? ListView.separated(
                        //           itemBuilder: (context, index) {
                        //             return commentBuilder(context, index);
                        //           },
                        //           separatorBuilder: (context, index) {
                        //             return const SizedBox(height: 15);
                        //           },
                        //           itemCount: postModel.comments?.length ?? 0,
                        //           physics: const BouncingScrollPhysics(),
                        //     shrinkWrap: true,
                        //         )
                        //       : const Center(
                        //           child: Text(
                        //             'No comments yet.',
                        //             style: TextStyle(
                        //               color: Colors.grey,
                        //               fontSize: 15,
                        //               fontWeight: FontWeight.w500,
                        //             ),
                        //           ),
                        //         ),
                        // ),

                        const SizedBox(height: 9),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 0.8,
                  width: double.maxFinite,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(
                    vertical: 1,
                  ),
                ),

                // add comment
                Row(
                  children: [
                    // user image
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            userModel.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 11),
                    // write a comment
                    Expanded(
                      child: TextFormField(
                        controller: commentController,
                        minLines: 1,
                        maxLines: 3,
                        onChanged: (value) {
                          cubit.sendCommentVisibility(value.trim());
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write a comment ..',
                        ),
                      ),
                    ),
                    if (cubit.showCommentSendButton)
                      MaterialButton(
                        onPressed: () {
                          dismissKeyboard(context);

                          cubit
                              .commentOnPost(
                            comment: commentController.text.trim(),
                            postModel: postModel,
                          )
                              .then((value) {
                            commentController.text = '';
                          });
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minWidth: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          IconBroken.Send,
                          color: Colors.blueAccent,
                          size: 23,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget commentBuilder(BuildContext context, int index) {
    var postModel = SocialCubit.get(context).posts[postIndex];
    var commentModel = postModel.comments![index];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // user image
        Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 8,
          ),
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  commentModel.userImage,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 11),

        // comment
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey[400]!,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          // margin: const EdgeInsets.symmetric(
          //   horizontal: 10,
          //   vertical: 10,
          // ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // name
              Text(
                commentModel.name,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              // comment
              Text(
                commentModel.comment,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 2),
      ],
    );
  }
}
