import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/modules/social_app/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/cubit/states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit().get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('News feed'),
          ),
          body: cubit.userModel != null
              ? Column(
                  children: [
                    // verify email
                    if (!FirebaseAuth.instance.currentUser!.emailVerified)
                      Container(
                        color: Colors.amber.withOpacity(.6),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber_outlined),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text('Please verify your Email!'),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification()
                                    .then((_) {
                                  cubit.userModel!.isEmailVerified = true;
                                  snkBar(
                                    context: context,
                                    title: 'Check your mail 📧',
                                  );
                                }).catchError((error) {
                                  log('error when sendEmailVerification: ${error.toString()}');
                                });
                              },
                              child: Text(
                                'Verify now'.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
