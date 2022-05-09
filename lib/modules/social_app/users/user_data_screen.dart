import 'package:firstapp/modules/social_app/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataScreen extends StatelessWidget {
  const UserDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // cover & profile pic
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  // cover
                  Container(
                    width: double.maxFinite,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          userModel!.cover,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // profile picture
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 135,
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
                              userModel.image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
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
                  userModel.name,
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
                  userModel.bio.isNotEmpty ? userModel.bio : 'Add bio ..',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
