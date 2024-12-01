import 'dart:convert';

import 'package:fishingshop/DTOs/reel_create_request.dart';
import 'package:fishingshop/DTOs/reel_edit_request.dart';
import 'package:fishingshop/model/reel.dart';
import 'package:fishingshop/service/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReelRepository {
  

  static Future<List<Reel>> getReels() async {
    var url = Uri.parse(baseURL + '/reels/');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);

    List responseList = json.decode(utf8.decode(response.bodyBytes));
    List<Reel> reels = [];
    for (Map reelMap in responseList) {
      Reel reel = Reel.fromMap(reelMap);
      reels.add(reel);
    }
    return reels;
  }
  static Future<void> addReel(ReelCreateRequest request,BuildContext context) async {
    var url = Uri.parse(baseURL + '/reels/');
    http.Response response = await http.post(
      url,
      headers: headers,
      body:  jsonEncode(request.toMap(request)),
    );
     print(response.body);
    
   if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Катушка добавлена!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Не удалось добавить катушку!"),
      ));
    }
  }
  static Future<void> editReel(ReelEditRequest request,BuildContext context) async {
    var url = Uri.parse(baseURL + '/reels/edit');
    http.Response response = await http.put(
      url,
      headers: headers,
      body:  jsonEncode(request.toMap(request)),
    );
     print(response.body);
    
   if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Катушка изменена!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Не удалось изменить катушку!"),
      ));
    }
  }

  static Future<void> deleteReel(int reelId,BuildContext context) async {
    var url = Uri.parse(baseURL + '/reels/'+reelId.toString());
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
     print(response.body);
    
   if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Катушка удалена!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Не удалось удалить катушку!"),
      ));
    }
  }
}