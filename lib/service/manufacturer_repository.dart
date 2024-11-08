import 'dart:convert';

import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/service/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<void> addManufacturer(String name, BuildContext context) async {
    var url = Uri.parse(baseURL + '/manufacturers/');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final headers = <String, String>{
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token",
    };

    http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"name": name}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Производитель добавлен!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Не удалось добавить производителя!"),
      ));
    }
    print(response.body);
  }

  static Future<void> editManufacturer(
      int id, String name, BuildContext context) async {
    var url = Uri.parse(baseURL + '/manufacturers/edit');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final headers = <String, String>{
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token",
    };

    http.Response response = await http.put(
      url,
      headers: headers,
      body: jsonEncode({"id": id, "name": name}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Производитель изменен!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Не удалось изменить производителя!"),
      ));
    }
    print(response.body);
  }
}
