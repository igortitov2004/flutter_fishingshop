import 'dart:convert';

import 'package:fishingshop/model/typeOfReel.dart';
import 'package:fishingshop/service/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  static Future<void> addTypeOfReel(String type, BuildContext context) async {
    var url = Uri.parse(baseURL + '/typeOfReels/');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final headers = <String, String>{
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token",
    };

    http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"type": type}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Тип добавлен!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Не удалось добавить тип!"),
      ));
    }
    print(response.body);
  }

  static Future<void> editTypeOfReel(
      int id, String type, BuildContext context) async {
    var url = Uri.parse(baseURL + '/typeOfReels/edit');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final headers = <String, String>{
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token",
    };

    http.Response response = await http.put(
      url,
      headers: headers,
      body: jsonEncode({"id": id, "type": type}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Тип изменен!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Не удалось изменить тип!"),
      ));
    }
    print(response.body);
  }
}