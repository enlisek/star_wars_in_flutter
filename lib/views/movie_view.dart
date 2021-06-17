import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/services/get_data.dart';
import 'package:star_wars_in_flutter/views/view_templates.dart';

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
  bool isPressed = false;


  void setupMovie() async {
    GetData getData = GetData();
    Map movie = await getData.getData(movieUrl);
    List<Map> mapsCharacters = await getData.getListOfData(movie['characters']);
    List<Map> mapsPlanets = await getData.getListOfData(movie['planets']);

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
  }

  @override
  void initState() {
    super.initState();
    //setupMovie();
  }

  @override
  Widget build(BuildContext context) {

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
