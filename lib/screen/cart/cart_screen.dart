import 'package:fishingshop/DTOs/cart.dart';
import 'package:fishingshop/model/reel.dart';
import 'package:fishingshop/service/cart_repository.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Cart? cart;

  getCart() async {
    cart = await CartRepository.getCart();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCart();
  }

  Future<void> removeReelCart(int reelId) async {
    await CartRepository.deleteFromReelCart(reelId,context); 
    getCart(); 
  }

  Future<void> removeRodCart(int rodId) async {
    await CartRepository.deleteFromRodCart(rodId,context); 
    getCart(); 
  }

  @override
  Widget build(BuildContext context) {
    return cart == null
        ? const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: const Text('Корзина'),
              centerTitle: true,
              backgroundColor: const Color(0xffffffff),
            ),
           // backgroundColor: Color(0x1200CCFF),
            body: Container(
              width: double.infinity,
              color: const Color(0x1200CCFF), // Цвет фона
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Text(
                      cart!.reelForCartResponseList.isNotEmpty || cart!.rodForCartResponseList.isNotEmpty ? 
                      'Общая стоимость: ${cart!.totalPrice.toStringAsFixed(2)} BYN' : 'Товары отсутствуют',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if(cart!.reelForCartResponseList.isNotEmpty || cart!.rodForCartResponseList.isNotEmpty)
                  Container(
                  //width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      //CartRepository.addReelCart(reel.id, context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Оформить заказ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                  if(cart!.reelForCartResponseList.isNotEmpty)
                  const SizedBox(height: 20),
                  if(cart!.reelForCartResponseList.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Text(
                      'Катушки:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if(cart!.reelForCartResponseList.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart!.reelForCartResponseList.length,
                      itemBuilder: (context, index) {
                        final reel = cart!.reelForCartResponseList[index];
                        return Dismissible(
                          key: Key(reel.reel.id.toString()), 
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
                             
                                  content: const Text('Вы уверены, что хотите удалить этот товар из корзины?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Отмена'),
                                      onPressed: () => Navigator.of(context).pop(false),
                                    ),
                                    TextButton(
                                      child: const Text('Удалить'),
                                      onPressed: () => Navigator.of(context).pop(true),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onDismissed: (direction) {
                            removeReelCart(reel.id); 
            
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            color: Colors.white, 
                            child: ListTile(
                              leading: Image.network(
                                reel.reel.link,
                                width: 60,
                                height: 60,
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/reelsDetails', arguments: reel.reel);
                              },
                              title: Text(reel.reel.name),
                              subtitle: Text(
                                'Цена: ${reel.reel.price.toStringAsFixed(2)} BYN\nКоличество: ${reel.amount}',
                              ),
                              trailing: Text('Итого: ${(reel.reel.price * reel.amount).toStringAsFixed(2)} BYN'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if(cart!.rodForCartResponseList.isNotEmpty)
                  const SizedBox(height: 20),
                  if(cart!.rodForCartResponseList.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Text(
                      'Удочки:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if(cart!.rodForCartResponseList.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart!.rodForCartResponseList.length,
                      itemBuilder: (context, index) {
                        final rod = cart!.rodForCartResponseList[index];
                        return Dismissible(
                          key: Key(rod.rod.id.toString()), 
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
                           
                                  content: const Text('Вы уверены, что хотите удалить этот товар из корзины?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Отмена'),
                                      onPressed: () => Navigator.of(context).pop(false),
                                    ),
                                    TextButton(
                                      child: const Text('Удалить'),
                                      onPressed: () => Navigator.of(context).pop(true),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onDismissed: (direction) {
                            removeRodCart(rod.id); 
                            
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            color: Colors.white,
                            child: ListTile(
                              leading: Image.network(
                                rod.rod.link,
                                width: 55, 
                                height: 55,
                                fit: BoxFit.cover,
                              ),
                               onTap: () {
                                Navigator.pushNamed(context, '/rodsDetails', arguments: rod.rod);
                              },
                              title: Text(rod.rod.name),
                              subtitle: Text(
                                'Цена: ${rod.rod.price.toStringAsFixed(2)} BYN\nКоличество: ${rod.amount}',
                              ),
                              trailing: Text('Итого: ${(rod.rod.price * rod.amount).toStringAsFixed(2)} BYN'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}