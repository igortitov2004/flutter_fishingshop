import 'dart:convert';

import 'package:fishingshop/DTOs/reel_create_request.dart';
import 'package:fishingshop/DTOs/reel_edit_request.dart';
import 'package:fishingshop/model/reel.dart';
import 'package:fishingshop/service/globals.dart';
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
  static Future<void> addReel(ReelCreateRequest request) async {
    var url = Uri.parse(baseURL + '/reels/');
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
  static Future<void> editRod(ReelEditRequest request) async {
    var url = Uri.parse(baseURL + '/reels/edit');
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

  static Future<void> deleteReel(int reelId) async {
    var url = Uri.parse(baseURL + '/reels/'+reelId.toString());
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