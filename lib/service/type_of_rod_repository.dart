import 'dart:convert';

import 'package:fishingshop/model/typeOfRod.dart';
import 'package:fishingshop/service/globals.dart';
import 'package:http/http.dart' as http;

class TypeOfRodRepository {
 

  static Future<List<TypeOfRod>> getTypesOfRod() async {
    var url = Uri.parse(baseURL + '/typesOfRods/');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = json.decode(utf8.decode(response.bodyBytes));
    List<TypeOfRod> typesOfRod = [];
    for (Map typeOfRodMap in responseList) {
      TypeOfRod typeOfRod = TypeOfRod.fromMap(typeOfRodMap);
      typesOfRod.add(typeOfRod);
    }
    return typesOfRod;
  }
}