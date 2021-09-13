import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/views/view_templates.dart';

class MainMenu1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[900],
      appBar: AppBar(
        //backgroundColor: Colors.yellow[600],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Theme.of(context).accentColor, //change your color here
        ),
        title: Text(
          'Star Wars App',
          style: TextStyle(
              color: Theme.of(context).accentColor,
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
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                SizedBox(height: 70),
                FlatButton(onPressed: () {
                  Navigator.pushNamed(context,'/list_view',arguments: 'people');
                } , color: Theme.of(context).buttonColor,
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),

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
                    color: Theme.of(context).buttonColor,
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),

                ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: oneRow('FILMS'),
                    )
                ),
                SizedBox(height: 20),
                FlatButton(onPressed: () {
                  Navigator.pushNamed(context,'/list_view',arguments: 'planets');
                } , color: Theme.of(context).buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),

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
