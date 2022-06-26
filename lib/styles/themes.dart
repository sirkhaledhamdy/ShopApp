import 'package:flutter/material.dart';

import 'colors.dart';


ThemeData lightTheme = ThemeData(
  fontFamily: 'Janna',
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  primarySwatch: defaultColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey.shade400,
    elevation: 15.0,
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: defaultColor,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
  ),
);
ThemeData darkTheme = ThemeData(
fontFamily: 'Janna',
  scaffoldBackgroundColor: Colors.grey.shade900,
  primarySwatch: Colors.grey,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey.shade300,
    elevation: 15.0,
    backgroundColor: Colors.grey.shade900,
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: Colors.grey.shade900,
    elevation: 0,
  ),

  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

);