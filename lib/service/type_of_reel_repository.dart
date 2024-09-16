import 'dart:convert';

import 'package:fishingshop/model/typeOfReel.dart';
import 'package:fishingshop/service/globals.dart';
import 'package:http/http.dart' as http;

class TypeOfReelRepository {
 

  static Future<List<TypeOfReel>> getTypesOfReel() async {
    var url = Uri.parse(baseURL + '/typeOfReels/');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = json.decode(utf8.decode(response.bodyBytes));
    List<TypeOfReel> typesOfReel = [];
    for (Map typeOfReelMap in responseList) {
      TypeOfReel typeOfReel = TypeOfReel.fromMap(typeOfReelMap);
      typesOfReel.add(typeOfReel);
    }
    return typesOfReel;
  }
}