import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/services/get_data.dart';
import 'package:star_wars_in_flutter/views/view_templates.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
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
  bool isFav = false;
  String category = '';
  List<String> filteredItems = [];


  @override
  void setupList() async {
    setState(() {
      items = [];
    });
    GetData getData = GetData();
    mapList =  await getData.getListOfDataFromAllPages(listUrl);
    //print("SetupList started...");
    final _dbTable = FirebaseDatabase.instance.reference().child(category);
    String child ='';
    switch(category) {
      case 'films':{
        child = "title_user_id";

      }
      break;
      case 'planets':{
        child = "planet_user_id";
      }
      break;
      default:{
        child = "person_user_id";
      }
    }
    print(child);

    //print("mapList calculated...");
    print("setState started...");
        if(!isFav){

          setState(() {

        items = getData.getDataByLabel(mapList, label);

      });
    }
    else{
          List<String> itemsHelp = [];
      await _dbTable.orderByChild(child).endAt(FirebaseAuth.instance.currentUser.uid)
          .once().then((DataSnapshot data)async{
            if(data.value!=null){
              print(data.value.keys);
              print(data.value);
              for (String k in data.value.keys) {
                dynamic res = await data.value[k];
                String id = res[child];
                String id_user = id.substring(id.length-FirebaseAuth.instance.currentUser.uid.length);
                print(id_user);
                print(FirebaseAuth.instance.currentUser.uid);
                if(id.substring(id.length-FirebaseAuth.instance.currentUser.uid.length)==FirebaseAuth.instance.currentUser.uid){
                  itemsHelp.add(id.substring(0,id.length-FirebaseAuth.instance.currentUser.uid.length));
                }


              }
              if(itemsHelp.isEmpty){
                itemsHelp.add("You have no favourites");
              }
           }
            else{
              itemsHelp.add("You have no favourites");
            }
      })
      ;
      setState(() {
        items = itemsHelp;
      });
    }
      print("SetupList ended...");
    // items = getData.getDataByLabel(mapList, label);
    filteredItems = items;
  }

  @override
  void initState() {
    super.initState();
    //setupList();
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      if(items.length == 0) {
        argument =  ModalRoute.of(context).settings.arguments ;
        listUrl = argument.startsWith("fav")?
        'https://swapi.dev/api/' + argument.substring(3) + '/?page=':
        'https://swapi.dev/api/' + argument + '/?page=';
        print(listUrl);

        isFav = argument.startsWith("fav");
        print(isFav);
        switch(argument) {
          case "films": {
            label = 'title';
          }
          break;
          case "favfilms":{
            label = 'title';
          }
          break;
          default: {
            label = 'name';
          }
          break;
        }
        category = argument.startsWith("fav")?argument.substring(3):argument;

        setupList();
      }


    });

    Future<List<String>> onSearch(String search) async {
      print("onSearch: " + search);
      print("onSearch: num of filtered: " + filteredItems.length.toString());
      print("onSearch: num of items: " + items.length.toString());
      setState(() {
        if(search!=null && search!="") {
          filteredItems=[];
          items.forEach((element) {
            if(element.contains(search)) {
              filteredItems.add(element);
            }
          }
          );
        }
        else {
          filteredItems = items;
        }
      });
      return filteredItems;
    }

    Future<List<String>> onCancelled() async {
      print("onCancelled: ");
      setState(() {
        filteredItems = items;
      });
      return filteredItems;
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Star Wars App',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBar<String> (
                    placeHolder: Text("Placeholder"),
                    onCancelled: onCancelled,
                    onSearch: onSearch,
                    onItemFound: (String str, int index) {
                      return Center();
                  },
                  minimumChars: 0,
                  icon: Icon(Icons.search, color:Colors.yellow),
                  textStyle: TextStyle(color: Colors.yellow),
                  cancellationText: Text("Cancel", style: TextStyle(color: Colors.yellow)),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              color: Colors.grey[800],
              margin: EdgeInsets.fromLTRB(20,0,20,30),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: filteredItems.map((element){
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FlatButton(
                                    onPressed: (){
                                      if(items[0]=="You have no favourites")
                                        {

                                        }
                                      else{
                                        print(element);
                                        switch(argument) {
                                          case "people":
                                            {
                                              Navigator.pushNamed(
                                                  context, '/person_view',
                                                  arguments: mapList[items.indexOf(
                                                      element)]['url']).then((_){
                                                        setupList();
                                              });
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
                                          case "favpeople":
                                            {
                                              int id = 0;
                                              for (var el in mapList){
                                                if(element == el['name'])
                                                id = mapList.indexOf(el);
                                              }
                                              Navigator.pushNamed(
                                                  context, '/person_view',
                                                  arguments: mapList[id]['url']).then((_){
                                                setupList();
                                              });;
                                            }
                                            break;
                                          case "favfilms":
                                            {
                                              int id = 0;
                                              for (var el in mapList){
                                                if(element == el['title'])
                                                  id = mapList.indexOf(el);
                                              }
                                              Navigator.pushNamed(
                                                  context, '/movie_view',
                                                  arguments: mapList[id]['url']).then((_){
                                                setupList();
                                              });;
                                            }
                                            break;
                                          case "favplanets":
                                            { int id = 0;
                                            for (var el in mapList){
                                              if(element == el['name'])
                                                id = mapList.indexOf(el);
                                            }
                                              Navigator.pushNamed(
                                                  context, '/planet_view',
                                                  arguments: mapList[id]['url']).then((_){
                                                setupList();
                                              });;
                                            }
                                            break;
                                        }
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
          ],
        ),
      ),
    );
  }

}
