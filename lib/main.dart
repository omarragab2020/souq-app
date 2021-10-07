import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app1/modules/shop/cubit/cubit.dart';
import 'package:flutter_app1/modules/shop/login/login-page.dart';
import 'package:flutter_app1/modules/shop/shop_layout.dart';
import 'package:flutter_app1/shared/blocObserver.dart';
import 'package:flutter_app1/shared/component/conestanse.dart';
import 'package:flutter_app1/shared/cubit/cubit.dart';
import 'package:flutter_app1/shared/cubit/states.dart';
import 'package:flutter_app1/shared/network/cacheHelper.dart';
import 'package:flutter_app1/shared/network/dioHelper.dart';
import 'package:flutter_app1/shared/styles/theme_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'modules/shop/onBoarding/on_boarding-screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

 /* if (uId != null) {
    widget = SocialLayOut();
  } else {
    widget = SocialLoginScreen();
  }*/
  runApp(MyApp(
    isDark: isDark,
    start: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget start;

  const MyApp({this.isDark, this.start});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()),
/*
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData(),
        ),
*/
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
/*
            darkTheme: darkTheme,
*/
/*
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
*/
            themeMode: ThemeMode.dark,
            home: /*FirebaseAuth.instance.currentUser == null
                ? SocialLoginScreen()
                : SocialLayOut(),*/
            ShopLayout()
          );
        },
      ),
    );
  }
}
