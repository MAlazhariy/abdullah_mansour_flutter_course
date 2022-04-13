import 'package:firstapp/modules/news_app/cubit/news_cubit.dart';
import 'package:firstapp/modules/news_app/cubit/news_states.dart';
import 'package:firstapp/modules/news_app/news_data.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {

          if(state is! NewsGetBusinessLoadingState){
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => newsItem(
                article: businessNewsData['articles'][index],
                context: context,
              ),
              separatorBuilder: (context, index) => separator(),
              itemCount: businessNewsData['articles'].length,
            );
          }
           return const Center(child: CircularProgressIndicator.adaptive());
        },
    );
  }
}
