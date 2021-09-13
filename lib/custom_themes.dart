import 'package:flutter/material.dart';

class MyThemes{
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey,
    accentColor: Colors.yellowAccent[700],
    scaffoldBackgroundColor: Colors.grey[400],
    buttonColor: Colors.grey[700],
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.yellowAccent[700]
    ),
  );
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor:Colors.grey[900] ,
    buttonColor: Colors.grey[700],
    brightness: Brightness.dark,
    primaryColor: Colors.grey[800],
    accentColor: Colors.yellowAccent[700],
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.yellowAccent[700]
    ),
  );
}