import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/services/get_data.dart';
import 'package:star_wars_in_flutter/views/view_templates.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

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
    final _dbTable = FirebaseDatabase.instance.reference().child('people');
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
    if(FirebaseAuth.instance.currentUser!=null){
      await _dbTable.orderByChild("person_user_id").equalTo(name + FirebaseAuth.instance.currentUser
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
    //setupPerson();
  }

  @override
  Widget build(BuildContext context) {
    final _dbTable = FirebaseDatabase.instance.reference().child('people');
    setState(() {
      if(gender=='') {
        personUrl = ModalRoute.of(context).settings.arguments;
        //print(personUrl);
        setupPerson();
      }

    });




    return Scaffold(
      //backgroundColor: Colors.grey[900],
      appBar: AppBar(
        //backgroundColor: Colors.yellow[600],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text(
            'Star Wars App',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Theme.of(context).buttonColor,
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
                        onPressed: () async {
                          if(FirebaseAuth.instance.currentUser != null){
                            if(!isPressed && gender!="") {
                              dynamic res = await _dbTable.push().set(
                                  {
                                    "person_user_id": name+ FirebaseAuth.instance.currentUser
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
                            else if(isPressed && gender!=""){
                              await _dbTable.orderByChild("person_user_id").equalTo(name + FirebaseAuth.instance.currentUser
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
                            color: (gender==""|| FirebaseAuth.instance.currentUser
                                ==null)?Colors.grey:Colors.red,
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

