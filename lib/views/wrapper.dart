import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_wars_in_flutter/views/home.dart';
import 'package:star_wars_in_flutter/views/main_menu_view.dart';
import 'package:star_wars_in_flutter/views/person_view.dart';
import 'package:star_wars_in_flutter/views/planet_view.dart';

import 'authentication/authenticate.dart';
import 'authentication/login.dart';
import 'authentication/register.dart';
import 'list_view.dart';
import 'movie_view.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
