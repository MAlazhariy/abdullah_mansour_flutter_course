
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firstapp/layout/home_age_calc.dart';
import 'package:firstapp/layout/news_app/news_layout.dart';
import 'package:firstapp/modules/shop_app/on_board_screen.dart';
import 'package:firstapp/modules/test/test.dart';
import 'package:firstapp/modules/todo_app/archived_task/archived_tasks_screen.dart';
import 'package:firstapp/modules/bmi_app/bmi/bmi_screen.dart';
import 'package:firstapp/modules/more_apps_screens/home/counter/counter_screen.dart';
import 'package:firstapp/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:firstapp/modules/more_apps_screens/home/home_screen.dart';
import 'package:firstapp/modules/more_apps_screens/home/login/login.dart';
import 'package:firstapp/modules/more_apps_screens/home/messenger/messenger_screen.dart';
import 'package:firstapp/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:firstapp/modules/more_apps_screens/home/messenger/users/users_list.dart';
import 'package:firstapp/shared/cubit/cubit.dart';
import 'package:firstapp/shared/cubit/states.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:firstapp/shared/osserver.dart';
import 'package:firstapp/shared/styles/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'layout/todo_layout.dart';
import 'modules/counter/counter_screen.dart';
import 'modules/shop_app/login_screen/login_screen.dart';
import 'package:bot_toast/bot_toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  AppCubit.isDark = (CacheHelper.getBool(key: 'isDark') != null)
      ? CacheHelper.getBool(key: 'isDark')
      : false;

  if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  final botToastBuilder = BotToastInit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
              create: (context) => AppCubit(),
          ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state){
      // AppCubit cubit = AppCubit.get(context);
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: AppCubit.isDark
          ? ThemeMode.dark
          : ThemeMode.light,

      builder: (context, child) {
        child = botToastBuilder(context,child);
        return child;
      },

      navigatorObservers: [BotToastNavigatorObserver()],

      home: Directionality(
          textDirection: TextDirection.ltr,
          child: Test(),
      ),
    );
  },
    listener: (context, state){},
    ),
    );

  }

}