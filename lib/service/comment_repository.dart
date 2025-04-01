import 'dart:convert';

import 'package:fishingshop/DTOs/reel_comment_creation_request.dart';
import 'package:fishingshop/DTOs/rod_comment_creation_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fishingshop/service/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CommentRepository{
    static Future<void> addRodComment(RodCommentCreationRequest request,BuildContext context) async {
    var url = Uri.parse('$baseURL' + '/rod-comment');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final headers = <String, String>{
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token",
    };
    http.Response response = await http.post(
      url,
      headers: headers,
      body:  jsonEncode(request.toMap(request)),
    );
     print(response.body);
    
   if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Комментарий сохранен!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Не удалось сохранить комментарий!"),
      ));
    }
  }

  static Future<void> addReelComment(ReelCommentCreationRequest request,BuildContext context) async {
    var url = Uri.parse('$baseURL' + '/reel-comment');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final headers = <String, String>{
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token",
    };
    http.Response response = await http.post(
      url,
      headers: headers,
      body:  jsonEncode(request.toMap(request)),
    );
     print(response.body);
    
   if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Комментарий сохранен!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Не удалось сохранить комментарий!"),
      ));
    }
  }
}