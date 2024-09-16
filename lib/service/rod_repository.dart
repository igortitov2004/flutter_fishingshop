import 'dart:convert';

import 'package:fishingshop/DTOs/rod_create_request.dart';
import 'package:fishingshop/DTOs/rod_edit_request.dart';
import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/model/rod.dart';
import 'package:fishingshop/model/typeOfRod.dart';
import 'package:fishingshop/service/globals.dart';
import 'package:http/http.dart' as http;

class RodRepository {
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

  static Future<List<Rod>> getRods() async {
    var url = Uri.parse(baseURL + '/rods/');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);

    List responseList = json.decode(utf8.decode(response.bodyBytes));
    List<Rod> rods = [];
    for (Map rodMap in responseList) {
      Rod rod = Rod.fromMap(rodMap);
      rods.add(rod);
    }
    return rods;
  }
  static Future<void> addRod(RodCreateRequest request) async {
    var url = Uri.parse(baseURL + '/rods/');
    http.Response response = await http.post(
      url,
      headers: headers,
      body:  jsonEncode(request.toMap(request)),
    );
     print(response.body);
    
   /*if (response.statusCode == 201) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Post created successfully!"),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to create post!"),
      ));
    }*/
  }
  static Future<void> editRod(RodEditRequest request) async {
    var url = Uri.parse(baseURL + '/rods/edit');
    http.Response response = await http.put(
      url,
      headers: headers,
      body:  jsonEncode(request.toMap(request)),
    );
     print(response.body);
    
   /*if (response.statusCode == 201) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Post created successfully!"),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to create post!"),
      ));
    }*/
  }

  static Future<void> deleteRod(int rodId) async {
    var url = Uri.parse(baseURL + '/rods/'+rodId.toString());
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
     print(response.body);
    
   /*if (response.statusCode == 201) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Post created successfully!"),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to create post!"),
      ));
    }*/
  }
}
