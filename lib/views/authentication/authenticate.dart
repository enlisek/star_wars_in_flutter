import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/custom_themes.dart';
import 'package:star_wars_in_flutter/views/authentication/register.dart';
import 'package:star_wars_in_flutter/views/main_menu_view_without_account.dart';

import '../list_view.dart';
import '../main_menu_view.dart';
import '../movie_view.dart';
import '../person_view.dart';
import '../planet_view.dart';
import 'login.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggle(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        initialRoute: '/login',
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        routes: {
        // '/person_view' : (BuildContext context) => PersonView(),
        // '/planet_view' : (context) => PlanetView(),
        // '/movie_view' : (context) => MovieView(),
        // '/list_view' : (context) => ListItemView(),
        // '/main_menu' : (context) => MainMenu(),
        '/login': (context)=>SignIn(),
        '/register':(context)=>Register(),
          '/main_view_model_without_account' : (context) => MainMenu1(),
          '/person_view' : (BuildContext context) => PersonView(),
          '/planet_view' : (context) => PlanetView(),
          '/movie_view' : (context) => MovieView(),
          '/list_view' : (context) => ListItemView(),
        },
    );

  }
}
