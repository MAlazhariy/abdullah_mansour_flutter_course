import 'dart:io';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firstapp/modules/more/battery_native_screen.dart';
import 'package:firstapp/modules/social_app/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/social_login/login_screen.dart';
import 'package:firstapp/shared/app_cubit/app_cubit.dart';
import 'package:firstapp/shared/app_cubit/app_states.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:firstapp/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> onBackgroundHandler(RemoteMessage message) async {
  log('onBackgroundMessage: ${message.data.toString()}');
  Fluttertoast.showToast(msg: 'onBackgroundMessage');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // API init
  DioHelper.init();
  // local DB init & open
  await Hive.initFlutter();
  await Hive.openBox('shop_app');

  // init Firebase
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //   apiKey: "AIzaSyDZ8RwjQKQPol5_t6LkWdokmlE_wyxF8E4",
      //   appId: "flutter.course.firstApp",
      //   messagingSenderId: "XXX",
      //   projectId: "flutter.course.firstApp",
      // ),
      );

  token = await FirebaseMessaging.instance.getToken() ?? '';
  // log(token);
  // AppCubit.isDark = CacheHelper.getBool(key: 'isDark') ?? false;

  FirebaseMessaging.onMessage.listen((event) {
    log('onMessage: ${event.data.toString()}');
    Fluttertoast.showToast(msg: 'on message');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    log('onMessageOpenedApp: ${event.data.toString()}');
    Fluttertoast.showToast(msg: 'onMessageOpenedApp');
  });

  FirebaseMessaging.onBackgroundMessage(onBackgroundHandler);

  if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final botToastBuilder = BotToastInit();

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    uId = CacheHelper.getSocialUId();

    return MultiBlocProvider(
      providers: [
        // to-do app cubit
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),

        // shop app cubit
        // BlocProvider(
        // create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),
        // ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          // AppCubit login_cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.isDark ? ThemeMode.dark : ThemeMode.light,
            // builder: (context, child) {
            //   child = botToastBuilder(context, child);
            //   return child;
            // },
            // navigatorObservers: [BotToastNavigatorObserver()],
            // home: _token.isEmpty ? ShopAppLoginScreen() : const ShopLayout(),
            home:
                uId.isEmpty ? SocialLoginScreen() : const BatteryNativeScreen(),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
