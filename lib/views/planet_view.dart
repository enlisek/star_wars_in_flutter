import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/services/get_data.dart';
import 'package:star_wars_in_flutter/views/view_templates.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
class PlanetView extends StatefulWidget {
  @override
  _PlanetViewState createState() => _PlanetViewState();
}

class _PlanetViewState extends State<PlanetView> {

  String planetUrl = 'http://swapi.dev/api/planets/1/';
  String name = 'loading...';
  String terrain = '';
  String rotation_period = '';
  String orbital_period = '';
  String climate = '';
  String gravity = '';
  List<String> residents = [];
  List<String> films = [];
  bool isPressed = false;


  void setupPlanet() async {
    GetData getData = GetData();
    Map planet = await getData.getData(planetUrl);
    List<Map> mapsFilms = await getData.getListOfData(planet['films']);
    List<Map> mapsResidents = await getData.getListOfData(planet['residents']);
    final _dbTable = FirebaseDatabase.instance.reference().child('planets');
    setState(() {
      name = planet['name'];
      terrain = planet['terrain'] ;
      rotation_period = planet['rotation_period'];
      orbital_period = planet['orbital_period'];
      climate = planet['climate'];
      gravity = planet['gravity'];
      films = getData.getDataByLabel(mapsFilms, 'title');

      residents = getData.getDataByLabel(mapsResidents, 'name');

    });
    if(FirebaseAuth.instance.currentUser!=null){
      await _dbTable.orderByChild("planet_user_id").equalTo(name + FirebaseAuth.instance.currentUser
          .uid).once().then((DataSnapshot data){
        setState(() {
          isPressed = (data.value!=null);
        });

        print(isPressed);
      });
    }

  }

  @override
  void initState() {
    super.initState();
    //setupPlanet();
  }

  @override
  Widget build(BuildContext context) {
    final _dbTable = FirebaseDatabase.instance.reference().child('planets');
    setState(() {
      if(terrain == '') {
        planetUrl = ModalRoute.of(context).settings.arguments;
        setupPlanet();
      }

    });

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
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
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          color: Colors.grey[800],
          margin: EdgeInsets.fromLTRB(20,30,20,30),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.values[3],
                    children: [
                      Icon(Icons.supervised_user_circle,
                        color: Colors.grey[100],
                        size: 70,
                      ),
                      FlatButton(
                          onPressed: () async{
                            if(FirebaseAuth.instance.currentUser != null){
                              if(!isPressed && terrain!="") {
                                dynamic res = await _dbTable.push().set(
                                    {
                                      "planet_user_id":name +  FirebaseAuth.instance.currentUser
                                          .uid
                                    }).asStream();
                                if (res == null) {
                                  Toast.show("Adding unsuccessful", context,
                                      gravity: Toast.CENTER);
                                }
                                else {
                                  Toast.show("Added successfully", context,
                                      gravity: Toast.CENTER);
                                  setState((){
                                    isPressed = true;
                                  });
                                }
                              }
                              else if(isPressed && terrain!=""){
                                await _dbTable.orderByChild("planet_user_id").equalTo(name +  FirebaseAuth.instance.currentUser
                                    .uid).limitToFirst(1)
                                    .once().then((DataSnapshot data){
                                  print(data.value.keys);
                                  String key = data.value.keys.toString();
                                  key = key.substring(1,key.length-1);
                                  print(key);
                                  _dbTable.child(key).remove();
                                  setState((){
                                    isPressed = false;
                                  });
                                });


                              }
                            }
                            else{
                              Toast.show("Create an account", context,
                                  gravity: Toast.CENTER);
                            }
                          },
                          child: Icon((isPressed) ? Icons.favorite : Icons.favorite_border,
                              color: (terrain==""|| FirebaseAuth.instance.currentUser
                                  ==null)?Colors.grey:Colors.red,
                              size: 40
                          )
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  oneColumn('NAME', name,CrossAxisAlignment.start),
                  SizedBox(height: 30),
                  oneColumn('TERRAIN',terrain ,CrossAxisAlignment.start),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      oneColumn('ROTATION PERIOD', rotation_period,CrossAxisAlignment.start),
                      oneColumn('ORBITAL PERIOD', orbital_period,CrossAxisAlignment.end)
                    ],
                  ),
                  SizedBox(height: 30),
                  oneColumn('CLIMATE', climate,CrossAxisAlignment.start),
                  SizedBox(height: 30),
                  oneColumn('GRAVITY', gravity,CrossAxisAlignment.start),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelText('MOVIES'),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: films.map((element){
                          return oneRow(element);
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelText('RESIDENTS'),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: residents.map((element){
                          return oneRow(element);
                        }).toList(),
                      ),
                    ],
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
