
import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/services/auth.dart';
import 'package:star_wars_in_flutter/views/authentication/login.dart';
import 'package:star_wars_in_flutter/views/movie_view.dart';
import 'package:star_wars_in_flutter/views/person_view.dart';
import 'package:star_wars_in_flutter/views/planet_view.dart';
import 'package:star_wars_in_flutter/views/list_view.dart';
import 'package:star_wars_in_flutter/views/main_menu_view.dart';
import 'package:star_wars_in_flutter/views/authentication/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_in_flutter/views/wrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(

      value: AuthService().user,
      child: Wrapper(),

    );


  }

}

