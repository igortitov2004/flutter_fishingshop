import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:fishingshop/service/globals.dart';

class ImageRepository {
  static Future<Uint8List?> fetchImage(int rodId) async {
    final String url = '$baseURL/rod/image/$rodId'; // Укажите URL вашего API
    
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.bodyBytes; // Возвращаем байты изображения
      } else {
        print('Ошибка: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Ошибка: $e');
      return null;
    }
  }
}