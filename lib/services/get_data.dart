import 'dart:convert';
import 'package:http/http.dart';

class GetData {

  Future<Map> getData(String url) async {
    String urlSecure = url;
    if(urlSecure.substring(0,5) != 'https'){
      urlSecure = urlSecure.substring(0,4) + 's' + urlSecure.substring(4);
    }
    Response response = await get(Uri.parse(urlSecure));
    //print(response.body);
    return jsonDecode(response.body);
  }

  Future<List<Map>> getListOfData(List<dynamic> list) async {
    print('starting getListOfData');
    List<String> secureUrls = [];
    List<Map> maps = [];
    Response response;

    list.forEach((element) {
      if(element.substring(0,5) != 'https'){
        //print(element.runtimeType);
        secureUrls.add(element.substring(0,4) + 's' + element.substring(4));
        //print(secureUrls);
      }
      else{
        secureUrls.add(element);
      }
    });
    for(var element in secureUrls) {
      response = await get(Uri.parse(element));
      //print(response.body);
      maps.add(jsonDecode(response.body));
    }
    print('ending getListOfData');
    //print(maps);
    return maps;
  }

  Future<List<Map>> getMapListFromStringList (List<String> list) async {

  }

  List<String> getDataByLabel(List<Map> maps, String label) {
    List<String> data = [];
    maps.forEach((element) {
      //print(element);
      data.add(element[label]);
    });
    return data;
  }

  Future<List<Map>> getListOfDataFromAllPages(String url) async {
    String secureUrl = url;
    if(secureUrl.substring(0,5) != 'https'){
      secureUrl = secureUrl.substring(0,4) + 's' + secureUrl.substring(4);
    }
    List<Map> maps = [];
    Response response;
    bool next = true;
    int i=1;
    while(next) {
      response = await get(Uri.parse(secureUrl+i.toString()));
      List<dynamic> json = jsonDecode(response.body)['results'];
      print(json[0].runtimeType);
      for(var item in json) {
        //print(item.runtimeType);
        maps.add(item as Map);
      }
      print(maps);
      print(i);
      if(jsonDecode(response.body)['next']!=null) {
          i++;
      }
      else {
        next = false;
      }
    }
    return maps;
  }

}