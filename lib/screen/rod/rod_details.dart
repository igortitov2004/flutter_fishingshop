import 'package:fishingshop/model/rod.dart';
import 'package:fishingshop/service/cart_repository.dart';
import 'package:fishingshop/service/rod_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RodDetails extends StatefulWidget {
  const RodDetails({Key? key}) : super(key: key);

  @override
  _RodDetailsState createState() => _RodDetailsState();
}

class _RodDetailsState extends State<RodDetails> {
  Rod? rod;
  String? role;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    rod = args as Rod;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _getRole();
  }

  Future<void> _getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(rod!.name),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                rod!.link,
                height: 350,
                width: 350,
              ),
              const SizedBox(height: 15),
              Text(
                "Удилище " +
                    rod!.type.type +
                    " " +
                    rod!.manufacturer.name +
                    " " +
                    rod!.name +
                    " \n" +
                    rod!.length.toString() +
                    " м, " +
                    rod!.testLoad.toString() +
                    " г",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Характеристики",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Производитель - " +
                    rod!.manufacturer.name +
                    "\n" +
                    "Длина, м. - " +
                    rod!.length.toString() +
                    "\n" +
                    "Тест до гр. " +
                    rod!.testLoad.toString() +
                    "\n" +
                    "Вес (гр.) - " +
                    rod!.weight.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              if (role != 'USER' && role!=null)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 2),
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             ...[
                              ElevatedButton(
                                onPressed: () {
                                  RodRepository.deleteRod(rod!.id);
                                  Navigator.pushNamed(context, '/rods');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.delete, color: Colors.white),
                                    SizedBox(width: 8),
                                    const Text(
                                      'Удалить',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/editRod', arguments: rod as Rod);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.edit, color: Colors.white),
                                    SizedBox(width: 8),
                                    const Text(
                                      'Изменить',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (role == 'USER' && role!=null)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                child: Container(
                  height: 90,
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              '${rod!.price} BYN',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Container(
                        width: 320,
                        child: ElevatedButton(
                          onPressed: () {
                            CartRepository.addRodCart(rod!.id, context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Купить',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}