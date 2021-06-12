import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/views/movie_view.dart';
import 'package:star_wars_in_flutter/views/person_view.dart';
import 'package:star_wars_in_flutter/views/planet_view.dart';
import 'package:star_wars_in_flutter/views/list_view.dart';
import 'package:star_wars_in_flutter/views/main_menu_view.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/main_menu',
    routes: {
      '/person_view' : (context) => PersonView(),
      '/planet_view' : (context) => PlanetView(),
      '/movie_view' : (context) => MovieView(),
      '/list_view' : (context) => ListItemView(),
      '/main_menu' : (context) => MainMenu(),
    },
  ));
}

