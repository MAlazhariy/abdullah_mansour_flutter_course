import 'dart:io';
import 'package:firstapp/modules/shop_app/login_screen.dart';
import 'package:firstapp/shared/app_cubit/app_cubit.dart';
import 'package:firstapp/shared/app_cubit/app_states.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:firstapp/shared/osserver.dart';
import 'package:firstapp/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:bot_toast/bot_toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  AppCubit.isDark = CacheHelper.getBool(key: 'isDark') ?? false;

  if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final botToastBuilder = BotToastInit();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => AppCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          // AppCubit cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.isDark ? ThemeMode.dark : ThemeMode.light,
            builder: (context, child) {
              child = botToastBuilder(context, child);
              return child;
            },
            navigatorObservers: [BotToastNavigatorObserver()],
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: ShopAppLoginScreen(),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
