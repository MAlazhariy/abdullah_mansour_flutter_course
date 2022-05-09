import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/modules/social_app/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/cubit/states.dart';
import 'package:firstapp/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:firstapp/modules/social_app/new_post/new_post_screen.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
              ),
            ],
          ),
          floatingActionButton: fAB(cubit.currentIndex, context),
          body: cubit.userModel != null
              ? Column(
                  children: [
                    Expanded(
                      child: cubit.screens[cubit.currentIndex],
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',
              ),
            ],
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }

  Widget? fAB(int currentIndex, BuildContext context) {
    if (currentIndex == 0) {
      // add a post
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewPostScreen(),
            ),
          );
        },
        child: const Icon(
          IconBroken.Paper_Upload,
          color: Colors.blueAccent,
          size: 30,
        ),
        tooltip: 'Add post',
        backgroundColor: Colors.white,
      );
    }
    else if (currentIndex == 3){
      // edit settings
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ),
          );
        },
        child: const Icon(
          IconBroken.Edit,
          color: Colors.blueAccent,
          size: 30,
        ),
        tooltip: 'Edit',
        backgroundColor: Colors.white,
      );
    }

    return null;
  }
}
