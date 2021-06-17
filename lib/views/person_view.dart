import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/services/get_data.dart';
import 'package:star_wars_in_flutter/views/view_templates.dart';


class PersonView extends StatefulWidget {
  @override
  _PersonViewState createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {

  String personUrl = 'http://swapi.dev/api/people/7/';
  String name = 'loading...';
  String gender = '';
  String height = '';
  String birth_year = '';
  String homeworld = '';
  String mass = "";
  String eye_color = '';
  String hair_color = '';
  List<String> films = [];
  bool isPressed = false;


  void setupPerson() async {
    GetData getData = GetData();
    Map person = await getData.getData(personUrl);
    Map planet = await getData.getData(person['homeworld']);
    //print(person['films'].runtimeType);
    //print(person['films']);
    //print('before getListOfData');
    List<Map> maps = await getData.getListOfData(person['films']);
    //print('after getListOfData');
    //print(person['films']);
    //print(maps);
    //print(films);
    setState(() {
      name = person['name'];
      gender = person['gender'];
      height = person['height'];
      birth_year = person['birth_year'];
      homeworld = planet['name'];
      mass = person['mass'];
      eye_color = person['eye_color'];
      hair_color = person['hair_color'];
      films = getData.getDataByLabel(maps, 'title');
    });
  }

  @override
  void initState() {
    super.initState();
    //setupPerson();
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      if(gender=='') {
        personUrl = ModalRoute.of(context).settings.arguments;
        //print(personUrl);
        setupPerson();
      }

    });




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
                    Icon(Icons.person,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    oneColumn('NAME', name,CrossAxisAlignment.start),
                    oneColumn('GENDER', gender,CrossAxisAlignment.end),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    oneColumn('BIRTH YEAR', birth_year,CrossAxisAlignment.start),
                    oneColumn('HOMEWORLD', homeworld,CrossAxisAlignment.end),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    oneColumn('HEIGHT', height,CrossAxisAlignment.start),
                    oneColumn('MASS', mass,CrossAxisAlignment.end)
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    oneColumn('EYE COLOR', eye_color,CrossAxisAlignment.start),
                    oneColumn('HAIR COLOR', hair_color,CrossAxisAlignment.end)
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
              ]
            ),
          ),
        ),
      ),
    );
  }
}

