import 'dart:developer';

import 'package:firstapp/layout/news_app/cubit/states.dart';
import 'package:firstapp/modules/news_app/business/business_screen.dart';
import 'package:firstapp/modules/news_app/science/science_screen.dart';
import 'package:firstapp/modules/news_app/sports/sports_screen.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentBottomIndex = 0;

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  void changeNavBar(index){
    currentBottomIndex = index;
    emit(NewsBottomNavBarState());
  }

  List businessNews = [];

  void getBusinessNews(){
    emit(NewsGetBusinessLoadingState());

    DioHelper.getDate(
      url: 'v2/top-headlines',
      query: {
        'country' : 'eg',
        'category' : 'business',
        // 'apiKey' : '65f7f556ec76449fa7dc7c0069f040ca',
        'apiKey' : '428705985b2a42ac9bf764cc3b1ccbf6',
      },
    ).then((value) {
      // businessNews = value.data['articles'];
      log(businessNews.toString());
      emit(NewsGetBusinessSuccessfulState());
    }).catchError((error){
      emit(NewsGetBusinessErrorState());
      log('-- Error from getBusinessNews() : ${error.toString()} -- error end');
    });
  }



}