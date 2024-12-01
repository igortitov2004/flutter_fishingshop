import 'dart:convert';

import 'package:fishingshop/DTOs/cart.dart';
import 'package:fishingshop/DTOs/order_response.dart';

import 'package:fishingshop/service/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepository {
  

  static Future<List<OrderResponse>> getOrders() async {
    var url = Uri.parse('$baseURL/orders/');
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final headers = <String, String>{
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token",
    };

    try {
      http.Response response = await http.get(url, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> ordersJson = json.decode(utf8.decode(response.bodyBytes));
        List<OrderResponse> orderResponses = ordersJson
            .map((order) => OrderResponse.fromMap(order))
            .toList();
        return orderResponses; // Возвращаем список объектов OrderResponse
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      rethrow; 
    }
  }
static Future<void> addOrder(String address, BuildContext context) async {
  var url = Uri.parse(baseURL + '/orders/');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  final headers = <String, String>{
    "Content-Type": "application/json; charset=utf-8",
    "Authorization": "Bearer $token",
  };

  http.Response response = await http.put(
    url,
    headers: headers,
    body: jsonEncode({"address": address}),
  );

  print(response.body);

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Заказ оформлен!"),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Не удалось оформить заказ!"),
    ));
  }
  print(response.body);
}




static Future<void> deleteOrder(int orderId, BuildContext context) async {
  var url = Uri.parse(baseURL + '/orders/$orderId');
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
        content: Text("Заказ удален!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Не удалось удалить заказ!"),
      ));
    }
    print(response.body);
  }
}