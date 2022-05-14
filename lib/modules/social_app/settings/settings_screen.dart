import 'package:firstapp/modules/social_app/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/cubit/states.dart';
import 'package:firstapp/modules/social_app/settings/update_bio_screen.dart';
import 'package:firstapp/modules/social_app/settings/update_cover_screen.dart';
import 'package:firstapp/shared/components/push.dart';
import 'package:firstapp/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        // var cubit.userModel = cubit.cubit.userModel;

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // cover & profile pic
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  // cover
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 170,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              cubit.userModel!.cover,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          cubit.getCoverImage(context);
                        },
                        minWidth: 0,
                        color: Colors.black38,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          IconBroken.Camera,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  // profile picture
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 100,
                        ),
                        child: Container(
                          width: 130,
                          height: 130,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  cubit.userModel!.image,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          cubit.getProfileImage(context);
                        },
                        minWidth: 0,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          IconBroken.Camera,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 11),
              // name
              Container(
                width: double.maxFinite,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  cubit.userModel!.name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              // bio
              Container(
                width: double.maxFinite,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  cubit.userModel!.bio.isNotEmpty
                      ? cubit.userModel!.bio
                      : 'Add bio ..',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              // edit bio
              TextButton(
                onPressed: () {
                  push(
                    context,
                    const UpdateBioScreen(),
                  );
                },
                child: const Text(
                  'edit bio',
                ),
              ),

              MaterialButton(
                child: const Text(
                  'LOGOUT',
                ),
                onPressed: () {
                  cubit.logout(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
