import 'package:firstapp/layout/news_app/cubit/cubti.dart';
import 'package:firstapp/layout/news_app/cubit/states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/news_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state){},
        builder: (BuildContext context, state){
          return ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index)=>newsItem(
                  article: scienceNewsData['articles'][index],
                  context: context
              ),
              separatorBuilder: (context, index)=>separator(),
              itemCount: scienceNewsData['articles'].length,
          );
        },
    );
  }
}
