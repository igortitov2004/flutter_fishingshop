import 'dart:convert';

import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/service/globals.dart';
import 'package:http/http.dart' as http;

class ManufacturerRepository {
  static Future<List<Manufacturer>> getManufacturers() async {
    var url = Uri.parse(baseURL + '/manufacturers/');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = json.decode(utf8.decode(response.bodyBytes));
    List<Manufacturer> manufacturers = [];
    for (Map manufacturerMap in responseList) {
      Manufacturer manufacturer = Manufacturer.fromMap(manufacturerMap);
      manufacturers.add(manufacturer);
    }
    return manufacturers;
  }

  
}