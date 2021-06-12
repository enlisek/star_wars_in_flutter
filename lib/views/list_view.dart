import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/services/get_data.dart';
import 'package:star_wars_in_flutter/views/view_templates.dart';

class ListItemView extends StatefulWidget {
  @override
  _ListItemViewState createState() => _ListItemViewState();
}

class _ListItemViewState extends State<ListItemView> {

  List<String> items = [];
  String listUrl = 'https://swapi.dev/api/people/?page=';
  String label = 'name';
  List<Map> mapList = [];
  String argument = '' ;



  void setupList() async {
    GetData getData = GetData();
    //print("SetupList started...");
    mapList =  await getData.getListOfDataFromAllPages(listUrl);
    //print("mapList calculated...");

    setState(() {
      //print("setState started...");
      items = getData.getDataByLabel(mapList, label);
    });
    //print("SetupList ended...");
  }

  @override
  void initState() {
    super.initState();
    //setupList();
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      argument =  ModalRoute.of(context).settings.arguments ;
      listUrl = 'https://swapi.dev/api/' + argument + '/?page=';

      switch(argument) {
        case "films": {
            label = 'title';
        }
        break;
        default: {
          label = 'name';
        }
        break;
      }

    });
    setupList();
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items.map((element){
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FlatButton(
                                onPressed: (){
                                  switch(argument) {
                                    case "people":
                                      {
                                        Navigator.pushNamed(
                                            context, '/person_view',
                                            arguments: mapList[items.indexOf(
                                                element)]['url']);
                                      }
                                      break;

                                    case "planets":
                                      {
                                        Navigator.pushNamed(
                                            context, '/planet_view',
                                            arguments: mapList[items.indexOf(
                                                element)]['url']);
                                      }
                                      break;

                                    case "films":
                                      {
                                        Navigator.pushNamed(
                                            context, '/movie_view',
                                            arguments: mapList[items.indexOf(
                                                element)]['url']);
                                      }
                                      break;
                                  }
                                  //Navigator.pushNamed(context, MaterialPageRoute(builder: (context) => PersonView('http://swapi.dev/api/people/7/')));
                                }, //TODO logika do przycisku
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    oneRow(element),
                                  ],
                                ),
                            )
                          ]
                          );
                    }).toList(),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }

}
