import 'dart:convert';

import 'package:fishingshop/DTOs/cart.dart';

import 'package:fishingshop/service/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  

  static Future<Cart> getCart() async {
    var url = Uri.parse('$baseURL/carts');
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final headers = <String, String>{
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token",
    };

    try {
    
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> cartJson = json.decode(utf8.decode(response.bodyBytes));
        Cart cart = Cart.fromMap(cartJson);
        return cart;
      } else {
        throw Exception('Failed to load cart: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      rethrow; 
    }
  }
static Future<void> addRodCart(int rodId, BuildContext context) async {
  var url = Uri.parse(baseURL + '/rodsCarts/');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  final headers = <String, String>{
    "Content-Type": "application/json; charset=utf-8",
    "Authorization": "Bearer $token",
  };

  http.Response response = await http.post(
    url,
    headers: headers,
    body: jsonEncode({"rodId": rodId}),
  );

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Удилище добавлено в корзину!"),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Не удалось добавить в корзину!"),
    ));
  }
  print(response.body);
}

static Future<void> addReelCart(int reelId, BuildContext context) async {
  var url = Uri.parse(baseURL + '/reelsCarts/');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  final headers = <String, String>{
    "Content-Type": "application/json; charset=utf-8",
    "Authorization": "Bearer $token",
  };

  http.Response response = await http.post(
    url,
    headers: headers,
    body: jsonEncode({"reelId": reelId}),
  );

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Катушка добавлена в корзину!"),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Не удалось добавить в корзину!"),
    ));
  }
  print(response.body);
}


static Future<void> deleteFromReelCart(int reelId, BuildContext context) async {
  var url = Uri.parse(baseURL + '/reelsCarts/$reelId');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final headers = <String, String>{
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token",
    };

    http.Response response = await http.delete(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Товар удален из корзины!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Не удалось удалить товар из корзины!"),
      ));
    }
    print(response.body);
  }

  static Future<void> deleteFromRodCart(int rodId, BuildContext context) async {
  var url = Uri.parse(baseURL + '/rodsCarts/$rodId');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final headers = <String, String>{
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token",
    };

    http.Response response = await http.delete(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Товар удален из корзины!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Не удалось удалить товар из корзины!"),
      ));
    }
    print(response.body);
  }


  static Future<void> increaseReelAmount(int reelId, BuildContext context) async {
  var url = Uri.parse(baseURL + '/reelsCarts/edit');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  final headers = <String, String>{
    "Content-Type": "application/json; charset=utf-8",
    "Authorization": "Bearer $token",
  };

  http.Response response = await http.put(
    url,
    headers: headers,
    body: jsonEncode({"id": reelId}),
  );
  print(response.body);
}

static Future<void> decreaseReelAmount(int reelId, BuildContext context) async {
  var url = Uri.parse(baseURL + '/reelsCarts/edit/dec');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  final headers = <String, String>{
    "Content-Type": "application/json; charset=utf-8",
    "Authorization": "Bearer $token",
  };

  http.Response response = await http.put(
    url,
    headers: headers,
    body: jsonEncode({"id": reelId}),
  );
  print(response.body);
}

  static Future<void> increaseRodAmount(int rodId, BuildContext context) async {
  var url = Uri.parse(baseURL + '/rodsCarts/edit');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  final headers = <String, String>{
    "Content-Type": "application/json; charset=utf-8",
    "Authorization": "Bearer $token",
  };

  http.Response response = await http.put(
    url,
    headers: headers,
    body: jsonEncode({"id": rodId}),
  );
  print(response.body);
}

static Future<void> decreaseRodAmount(int rodId, BuildContext context) async {
  var url = Uri.parse(baseURL + '/rodsCarts/edit/dec');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  final headers = <String, String>{
    "Content-Type": "application/json; charset=utf-8",
    "Authorization": "Bearer $token",
  };

  http.Response response = await http.put(
    url,
    headers: headers,
    body: jsonEncode({"id": rodId}),
  );
  print(response.body);
}




  /*
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
  }*/
}