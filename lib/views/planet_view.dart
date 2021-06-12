import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/services/get_data.dart';
import 'package:star_wars_in_flutter/views/view_templates.dart';

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

    setState(() {
      name = planet['name'];
      terrain = planet['terrain'] ;
      rotation_period = planet['rotation_period'];
      orbital_period = planet['orbital_period'];
      climate = planet['climate'];
      gravity = planet['gravity'];
      films = getData.getDataByLabel(mapsFilms, 'title');
      print(films);
      residents = getData.getDataByLabel(mapsResidents, 'name');
      print(residents);
    });
  }

  @override
  void initState() {
    super.initState();
    //setupPlanet();
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      planetUrl = ModalRoute.of(context).settings.arguments;
    });

    setupPlanet();

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
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
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
                          onPressed: () {
                            setState(() {
                              //TODO trzeba dodawac warunek czy uzytkownik jest zalogowany
                              //jesli nie to info zeby sie zalogowal
                              //jesli tak to zmienia sie przycisk plus dodaje sie pozycja do firebase/ewentualnie usuwa
                              isPressed = !isPressed;
                            });
                          },
                          child: Icon((isPressed) ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
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
                      oneColumn('CLIMATE', climate,CrossAxisAlignment.end),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      oneColumn('ORBITAL PERIOD', orbital_period,CrossAxisAlignment.start),
                      oneColumn('GRAVITY', gravity,CrossAxisAlignment.end)
                    ],
                  ),
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
