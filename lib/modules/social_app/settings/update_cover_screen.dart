import 'package:firstapp/modules/social_app/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/cubit/states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateCoverScreen extends StatelessWidget {
  const UpdateCoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialUpdateFireStoreCoverSuccessState) {
          Navigator.pop(context);
          snkBar(context: context, title: 'updated successfully',);
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Update cover photo',
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
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                if(state is SocialUploadCoverLoadingState)
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 11,
                    ),
                    child: LinearProgressIndicator(),
                  ),

                Container(
                  width: double.maxFinite,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      // topLeft: Radius.circular(10),
                      // topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: FileImage(
                        cubit.coverImage!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Spacer(),
                MaterialButton(
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    cubit.uploadCoverImage();
                  },
                  color: Colors.blueAccent,
                  // minWidth: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 11,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
