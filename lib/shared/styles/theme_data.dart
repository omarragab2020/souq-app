import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarBrightness: Brightness.light),
    backgroundColor: HexColor('333739'),
    elevation: 0,
    titleTextStyle: TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20,
    backgroundColor: HexColor('333739'),
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
    subtitle1: TextStyle(
        height: 1.3,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black),
  ),
  fontFamily: 'Jannah',
);
ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black, statusBarBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
          fontFamily: 'Jannah',
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          fontFamily: 'Jannah',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black),
      subtitle1: TextStyle(
          height: 1.3,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white),
    ),
    fontFamily: 'Jannah');

/*Container(
                      color: Colors.amber.withOpacity(.6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(child: Text('please verify your email')),
                            SizedBox(
                              width: 20,
                            ),
                            defaultTextButton(
                                function: () {
                                  FirebaseAuth.instance.currentUser
                                      .sendEmailVerification()
                                      .then((value) {
                                    showToast(
                                        text: 'Check your email',
                                        state: ToastStates.SUCCESS);
                                  }).catchError((error) {});
                                },
                                text: 'send')
                          ],
                        ),
                      ),
                    ),*/
