import 'package:firstapp/modules/news_app/cubit/news_cubit.dart';
import 'package:firstapp/modules/news_app/cubit/news_states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/modules/news_app/news_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state){},
        builder: (context, state){
          return ListView.separated(
              itemBuilder: (context, index) => newsItem(
                  article: sportsNewsData['articles'][index],
                  context: context,
              ),
              separatorBuilder: (context, index) => separator(),
              itemCount: sportsNewsData['articles'].length,
            physics: const BouncingScrollPhysics(),
          );
        },
    );
  }
}
