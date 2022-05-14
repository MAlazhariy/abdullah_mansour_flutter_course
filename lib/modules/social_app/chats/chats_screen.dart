import 'package:firstapp/models/social_app/social_user_model.dart';
import 'package:firstapp/modules/social_app/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return userBuilder(
                userModel: cubit.users[index],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemCount: cubit.users.length,
            physics: const BouncingScrollPhysics(),
          ),
        );
      },
    );
  }

  Widget userBuilder({required SocialUserModel userModel}) {
    return Container(
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
      margin: const EdgeInsets.symmetric(
        horizontal: 1.5,
        vertical: 1.5,
      ),

      child: MaterialButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        child: Row(
          children: [
            // user image
            Container(
              width: 40,
              height: 40,
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
            // user name
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
                if (userModel.name == 'Mostafa Alazhariy')
                  const Icon(
                    Icons.check_circle,
                    color: Colors.blueAccent,
                    size: 14.5,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
