import 'package:fishingshop/DTOs/order_response.dart';
import 'package:fishingshop/screen/order/order_detail_screen.dart';
import 'package:fishingshop/service/order_repository.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrderResponse>? orders;

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  getOrders() async {
    orders = await OrderRepository.getOrders();
    setState(() {});
  }

  Future<void> removeOrder(int orderId) async {
    await OrderRepository.deleteOrder(orderId, context);
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: const Text('Заказы'),
              centerTitle: true,
              backgroundColor: const Color(0xffffffff),
            ),
            body: Container(
              width: double.infinity,
              color: const Color(0x1200CCFF),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: ListView.builder(
                itemCount: orders!.length,
                itemBuilder: (context, index) {
                  final order = orders![index];
                  return Dismissible(
                    key: Key(order.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: const Text(
                                'Вы уверены, что хотите удалить этот заказ?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Отмена'),
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                              ),
                              TextButton(
                                child: const Text('Удалить'),
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      removeOrder(order.id);
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      color: Colors.white,
                      child: ListTile(
                        title: Text('Заказ #${order.id}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Общая стоимость: ${order.totalPrice.toStringAsFixed(2)} BYN',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                             Text('Адрес: ${order.address}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            
                            Text('Дата и время: ${order.localDateTime}',
                            style: const TextStyle(fontSize: 16,color: Colors.green)),
                            const SizedBox(height: 5),
                            const Text('Товары:',
                            style: const TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                            ...order.reelsForOrderResponseList.map((reel) {
                              return Text('${reel.reel.name} - ${reel.amount} шт. (${(reel.reel.price * reel.amount).toStringAsFixed(2)} BYN)',
                              style: const TextStyle(fontSize: 16));
                            }).toList(),
                            ...order.rodsForOrderResponseList.map((rod) {
                              return Text('${rod.rod.name} - ${rod.amount} шт. (${(rod.rod.price * rod.amount).toStringAsFixed(2)} BYN)');
                            }).toList(),
                          ],
                        ),
                        onTap: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailScreen(order: order),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}