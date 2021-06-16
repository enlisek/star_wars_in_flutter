import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/views/person_view.dart';
import 'package:star_wars_in_flutter/views/planet_view.dart';

import 'authentication/login.dart';
import 'list_view.dart';
import 'main_menu_view.dart';
import 'movie_view.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/main_menu',
      routes: {
        '/person_view' : (BuildContext context) => PersonView(),
        '/planet_view' : (context) => PlanetView(),
        '/movie_view' : (context) => MovieView(),
        '/list_view' : (context) => ListItemView(),
        '/main_menu' : (context) => MainMenu(),

      },
    );
  }
}
