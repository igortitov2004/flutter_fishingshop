import 'package:fishingshop/screen/comment/create_comment_screen.dart';
import 'package:fishingshop/screen/user/personal_screen.dart';
import 'package:fishingshop/service/order_repository.dart';
import 'package:fishingshop/tiles/reel_tile.dart';
import 'package:fishingshop/tiles/rod_tile.dart';
import 'package:flutter/material.dart';
import 'package:fishingshop/DTOs/order_response.dart'; // Импортируйте ваш OrderResponse

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late Future<List<OrderResponse>> ordersFuture;

  @override
  void initState() {
    super.initState();
    ordersFuture = getOrders(); // Получаем заказы при инициализации
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PersonalScreen()),
            );
          },
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text('История заказов'),
        centerTitle: true,
      ),
      body: Scaffold(
        backgroundColor:
            const Color(0x1200CCFF), // Установка цвета фона для Scaffold
        body: FutureBuilder<List<OrderResponse>>(
          future: ordersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Нет заказов.'));
            }

            final orders = snapshot.data!;

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: const Color.fromARGB(255, 205, 218, 243),
                          elevation: 4.0,
                          margin: EdgeInsets.all(2.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${order.localDateTime}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Общая сумма: ${order.totalPrice.toStringAsFixed(2)} BYN',
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Размещение катушек с звёздочками
                        for (int i = 0;
                            i < order.reelsForOrderResponseList.length;
                            i += 2)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (i < order.reelsForOrderResponseList.length)
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      height: 255,
                                      child: ReelTile(
                                          reel: order
                                              .reelsForOrderResponseList[i]
                                              .reel),
                                    ),
                                    Positioned(
                                      top: 10.0,
                                      right: 10.0,
                                      child: IconButton(
                                        icon: Icon(Icons.star,
                                            color: Colors.blue),
                                        onPressed: () {
                                          // Переход на экран создания отзыва
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateCommentScreen(
                                                productId: order
                                                    .reelsForOrderResponseList[
                                                        i]
                                                    .reel
                                                    .id,
                                                productType: "reel",
                                              ), // Замените на актуальное имя товара
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              if (i + 1 <
                                  order.reelsForOrderResponseList.length)
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      height: 255,
                                      child: ReelTile(
                                          reel: order
                                              .reelsForOrderResponseList[i + 1]
                                              .reel),
                                    ),
                                    Positioned(
                                      top: 10.0,
                                      right: 10.0,
                                      child: IconButton(
                                        icon: Icon(Icons.star,
                                            color: Colors.blue),
                                        onPressed: () {
                                          // Переход на экран создания отзыва
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateCommentScreen(
                                                productId: order
                                                    .reelsForOrderResponseList[
                                                        i + 1]
                                                    .reel
                                                    .id,
                                                productType: "reel",
                                              ), // Замените на актуальное имя товара
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),

                        // Размещение удилищ с звёздочками
                        for (int j = 0;
                            j < order.rodsForOrderResponseList.length;
                            j += 2)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (j < order.rodsForOrderResponseList.length)
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      height: 270,
                                      child: RodTile(
                                          rod: order
                                              .rodsForOrderResponseList[j].rod),
                                    ),
                                    Positioned(
                                      top: 10.0,
                                      right: 10.0,
                                      child: IconButton(
                                        icon: Icon(Icons.star,
                                            color: Colors.blue),
                                        onPressed: () {
                                          // Переход на экран создания отзыва
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateCommentScreen(
                                                productId: order
                                                    .rodsForOrderResponseList[j]
                                                    .rod
                                                    .id,
                                                productType: "rod",
                                              ), // Замените на актуальное имя товара
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              if (j + 1 < order.rodsForOrderResponseList.length)
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      height: 270,
                                      child: RodTile(
                                          rod: order
                                              .rodsForOrderResponseList[j + 1]
                                              .rod),
                                    ),
                                    Positioned(
                                      top: 10.0,
                                      right: 10.0,
                                      child: IconButton(
                                        icon: Icon(Icons.star,
                                            color: Colors.blue),
                                        onPressed: () {
                                          // Переход на экран создания отзыва
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateCommentScreen(
                                                productId: order
                                                    .rodsForOrderResponseList[
                                                        j + 1]
                                                    .rod
                                                    .id,
                                                productType: "rod",
                                              ), // Замените на актуальное имя товара
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<OrderResponse>> getOrders() async {
    // Получаем заказы
    return await OrderRepository
        .getOrders(); // Предполагается, что у вас есть OrderService с методом getOrders
  }
}
