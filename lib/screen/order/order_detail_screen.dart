import 'dart:typed_data';

import 'package:fishingshop/DTOs/order_response.dart';
import 'package:fishingshop/model/reel.dart';
import 'package:fishingshop/model/rod.dart';
import 'package:fishingshop/screen/reel/reel_details.dart';
import 'package:fishingshop/screen/rod/rod_details.dart';
import 'package:fishingshop/service/image_repository.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderResponse order;

  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);
  static final Map<int, Uint8List?> imageCache = {}; // Кэш для изображений

  Future<Uint8List?> _loadRodImage(int id) async {
    if (imageCache.containsKey(id)) {
      return imageCache[id]; // Загружаем из кэша
    } else {
      // Если нет в кэше, загружаем из сети
      Uint8List? bytes = await ImageRepository.fetchImage(id);
      if (bytes != null) {
        imageCache[id] = bytes; // Сохраняем в кэше
      }
      return bytes; // Возвращаем загруженные байты
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали заказа #${order.id}'),
        centerTitle: true,
        backgroundColor: const Color(0xffffffff),
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0x1200CCFF),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Общая стоимость: ${order.totalPrice.toStringAsFixed(2)} BYN',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: order.reelsForOrderResponseList.length +
                    order.rodsForOrderResponseList.length,
                itemBuilder: (context, index) {
                  if (index < order.reelsForOrderResponseList.length) {
                    final reel = order.reelsForOrderResponseList[index];
                    return _buildItem(context,
                        name: reel.reel.name,
                        amount: reel.amount,
                        total: reel.reel.price * reel.amount,
                        imageUrl: reel.reel.link,
                        isReel: true, // Указываем, что это катушка
                        reel: reel.reel);
                  } else {
                    final rod = order.rodsForOrderResponseList[
                        index - order.reelsForOrderResponseList.length];
                    return _buildItem(context,
                        name: rod.rod.name,
                        amount: rod.amount,
                        total: rod.rod.price * rod.amount,
                        imageUrl: rod.rod.link,
                        isReel: false, // Указываем, что это удочка
                        rod: rod.rod);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context,
      {required String name,
      required int amount,
      required double total,
      required String imageUrl,
      required bool isReel,
      Reel? reel,
      Rod? rod // Добавляем параметр для определения типа товара
      }) {
    return InkWell(
      onTap: () async {
        // Переход на соответствующий экран в зависимости от типа товара
        if (isReel) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReelDetails(),
              settings: RouteSettings(arguments: reel),
            ),
          );
        } else {
          Uint8List? imageBytes = await _loadRodImage(rod!.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RodDetails(),
              settings: RouteSettings(arguments: {
            'rod': rod,
            'imageBytes': imageBytes,
          }),
            ),
          );
        }
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          height: 90,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              if (isReel)
                Center(
                  child: Image.network(imageUrl, width: 70, height: 70),
                ),
              if (!isReel)
                Center(
                  child: FutureBuilder<Uint8List?>(
                    future: _loadRodImage(rod!.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          width: 55,
                          height: 55,
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData && snapshot.data != null) {
                        return Image.memory(
                          snapshot.data!,
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return const SizedBox(
                          width: 55,
                          height: 55,
                          child: Icon(Icons.error),
                        );
                      }
                    },
                  ),
                ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${total.toStringAsFixed(2)} BYN',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      '$name - $amount шт.',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
