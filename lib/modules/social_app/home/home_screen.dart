import 'dart:developer';

import 'package:firstapp/modules/social_app/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/cubit/states.dart';
import 'package:firstapp/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;

        return ListView.separated(
          itemBuilder: (context, index){
            return Container(
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
                vertical: 5,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
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
                              userModel!.image,
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
                                  userModel.name,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.blueAccent,
                                  size: 14.5,
                                ),
                              ],
                            ),
                            const Text(
                              'January 21, 2021 at 11:00 am',
                              style: TextStyle(
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
                  // content
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a tortor et nulla porttitor placerat vitae nec nulla. Vivamus molestie lectus quis magna pulvinar, vel efficitur tortor euismod. Sed nec tortor eget diam ornare molestie non quis turpis. Mauris maximus lectus non tortor porttitor bibendum. Aliquam id hendrerit dolor. Sed.',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // hashes
                  Wrap(
                    // crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    spacing: 5,
                    children: [
                      SizedBox(
                        height: 21.5,
                        child: MaterialButton(
                          child: const Text(
                            '#MAlazhariy',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 0,
                          elevation: 0,
                        ),
                      ),
                      SizedBox(
                        height: 21.5,
                        child: MaterialButton(
                          child: const Text(
                            '#software',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 0,
                          elevation: 0,
                        ),
                      ),
                      SizedBox(
                        height: 21.5,
                        child: MaterialButton(
                          child: const Text(
                            '#flutter',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 0,
                          elevation: 0,
                        ),
                      ),
                      SizedBox(
                        height: 21.5,
                        child: MaterialButton(
                          child: const Text(
                            '#software_developer',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 0,
                          elevation: 0,
                        ),
                      ),
                      SizedBox(
                        height: 21.5,
                        child: MaterialButton(
                          child: const Text(
                            '#flutter_developer',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 0,
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // post image
                  Container(
                    width: double.maxFinite,
                    height: 200,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: NetworkImage(
                          // '',
                          'https://scontent.fcai19-2.fna.fbcdn.net/v/t39.30808-6/253620289_4453538871399785_1719264920345784547_n.jpg?_nc_cat=106&ccb=1-6&_nc_sid=730e14&_nc_eui2=AeGUJYzDCZSBd_MtXTUy9hS8TCjaJtvaM95MKNom29oz3s62Q3Gmor_7ee9wuUE_PwyIGMcTTYF1RbiSoW5mFe_W&_nc_ohc=Z5F8rjKudYwAX89mtEK&_nc_ht=scontent.fcai19-2.fna&oh=00_AT8exC-JgOuGzh1vGZA3gUs0GwiccQwTl9FaKskN7hFSng&oe=627CB912',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 11),
                  // comments and likes
                  Row(
                    children: const [
                      Icon(
                        IconBroken.Heart,
                        size: 20,
                        color: Colors.pink,
                      ),
                      SizedBox(width: 3.5),
                      Text(
                        '120',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        IconBroken.Chat,
                        size: 20,
                        color: Colors.green,
                      ),
                      SizedBox(width: 3.5),
                      Text(
                        '16 comments',
                        style: TextStyle(
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
                  // comment & like
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      const Text(
                        'write a comment ...',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 3),
                      // like
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.pink,
                        size: 19,
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        'like',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index){
            return const SizedBox(
              height: 8,
            );
          },
          itemCount: 10,
        );
      },
    );
  }
}
