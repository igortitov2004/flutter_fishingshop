import 'dart:convert';

import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/model/rod.dart';
import 'package:fishingshop/service/globals.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Manufacturer>> getManufacturers() async {
    var url = Uri.parse(baseURL + '/manufacturers/');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = jsonDecode(response.body);
    List<Manufacturer> manufacturers = [];
    for (Map manufacturerMap in responseList) {
      Manufacturer manufacturer = Manufacturer.fromMap(manufacturerMap);
      manufacturers.add(manufacturer);
    }
    return manufacturers;
  }

  static Future<List<Rod>> getRods() async {
    var url = Uri.parse(baseURL + '/rods/');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);

    List responseList = jsonDecode(response.body);
    List<Rod> rods = [];
    for (Map rodMap in responseList) {
      Rod rod = Rod.fromMap(rodMap);
      rods.add(rod);
    }
    return rods;
  }
}
