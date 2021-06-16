import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/views/view_templates.dart';

class MainMenu1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: Text(
          'Star Wars App',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                Center(
                  child: Text( 'StarWars',
                    style: TextStyle(
                      fontFamily: 'StarWars',
                      fontSize: 55,
                      color: Colors.amberAccent[200],
                    ),
                  ),
                ),
                SizedBox(height: 70),
                FlatButton(onPressed: () {
                  Navigator.pushNamed(context,'/list_view',arguments: 'people');
                } , color: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.grey[900].withOpacity(0.1),
                    width: 3,
                  ),
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: oneRow('PEOPLE'),
                  )
                ),
                SizedBox(height: 20),
                FlatButton(onPressed: () {
                  Navigator.pushNamed(context,'/list_view',arguments: 'films');
                } ,
                    color: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.grey[900].withOpacity(0.1),
                    width: 3,
                  ),
                ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: oneRow('FILMS'),
                    )
                ),
                SizedBox(height: 20),
                FlatButton(onPressed: () {
                  Navigator.pushNamed(context,'/list_view',arguments: 'planets');
                } , color: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.grey[900].withOpacity(0.1),
                        width: 3,
                      ),
                    ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: oneRow('PLANETS'),
                  )
                ),
              ]
          ),
        ),
      ),
    );
  }
}
