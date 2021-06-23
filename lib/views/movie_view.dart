import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/services/get_data.dart';
import 'package:star_wars_in_flutter/views/view_templates.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
class MovieView extends StatefulWidget {
  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {

  String movieUrl = 'http://swapi.dev/api/films/1/';
  String title = 'loading...';
  String episode_id = '';
  String opening_crawl = '';
  String director = '';
  String release_date = '';
  List<String> characters = [];
  List<String> planets = [];
  bool isPressed = false ;


  void setupMovie() async {
    GetData getData = GetData();
    Map movie = await getData.getData(movieUrl);
    List<Map> mapsCharacters = await getData.getListOfData(movie['characters']);
    List<Map> mapsPlanets = await getData.getListOfData(movie['planets']);
    final _dbTable = FirebaseDatabase.instance.reference().child('films');

    // List<Map> proba =  await getData.getListOfDataFromAllPages('https://swapi.dev/api/planets/?page=');
    // print(proba);

    setState(() {
      title = movie['title'];
      episode_id = movie['episode_id'].toString();
      opening_crawl = movie['opening_crawl'].replaceAll('\r\n', ' ');
      director = movie['director'];
      release_date = movie['release_date'];
      characters = getData.getDataByLabel(mapsCharacters, 'name');
      planets = getData.getDataByLabel(mapsPlanets, 'name');

    });
    if(FirebaseAuth.instance.currentUser!=null){
      await _dbTable.orderByChild("title_user_id").equalTo(title+ FirebaseAuth.instance.currentUser
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
    //setupMovie();
  }

  @override
  Widget build(BuildContext context) {
    final _dbTable = FirebaseDatabase.instance.reference().child('films');
    setState(() {
      if(director == '') {
        movieUrl = ModalRoute.of(context).settings.arguments;
        setupMovie();
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
          margin: EdgeInsets.fromLTRB(16,20,16,20),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.values[3],
                    children: [
                      Icon(Icons.movie_creation_outlined,
                        color: Colors.grey[100],
                        size: 70,
                      ),
                      FlatButton(
                          onPressed: () async{
                            if(FirebaseAuth.instance.currentUser != null){
                              if(!isPressed && episode_id!="") {
                                dynamic res = await _dbTable.push().set(
                                    {
                                      "title_user_id": title + FirebaseAuth.instance.currentUser
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
                              else if(isPressed && episode_id!=""){
                                await _dbTable.orderByChild("title_user_id").equalTo(title + FirebaseAuth.instance.currentUser
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
                            }                            if(FirebaseAuth.instance.currentUser != null){
                              if(!isPressed && episode_id!="") {
                                dynamic res = await _dbTable.push().set(
                                    {
                                      "title_user_id": title + FirebaseAuth.instance.currentUser
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
                              else if(isPressed && episode_id!=""){
                                await _dbTable.orderByChild("title_user_id").equalTo(title + FirebaseAuth.instance.currentUser
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
                            }                if(FirebaseAuth.instance.currentUser != null){
                              if(!isPressed && episode_id!="") {
                                dynamic res = await _dbTable.push().set(
                                    {
                                      "title_user_id": title + FirebaseAuth.instance.currentUser
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
                              else if(isPressed && episode_id!=""){
                                 await _dbTable.orderByChild("title_user_id").equalTo(title + FirebaseAuth.instance.currentUser
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
                              color: (episode_id==""|| FirebaseAuth.instance.currentUser
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
                      oneColumn('TITLE', title,CrossAxisAlignment.start),
                      oneColumn('EPISODE ID',episode_id ,CrossAxisAlignment.end),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      oneColumn('DIRECTOR', director,CrossAxisAlignment.start),
                      oneColumn('RELEASE DATE', release_date,CrossAxisAlignment.end),
                    ],
                  ),
                  SizedBox(height: 30),
                  oneColumn('OPENING CRAWL', opening_crawl,CrossAxisAlignment.start),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelText('CHARACTERS'),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: characters.map((element){
                          return oneRow(element);
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelText('PLANETS'),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: planets.map((element){
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
