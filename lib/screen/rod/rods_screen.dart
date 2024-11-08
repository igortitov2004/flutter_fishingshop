import 'package:fishingshop/model/rod.dart';

import 'package:fishingshop/tiles/rod_tile.dart';
import 'package:fishingshop/service/rod_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RodsScreen extends StatefulWidget {
  const RodsScreen({Key? key}) : super(key: key);

  @override
  _RodsScreenState createState() => _RodsScreenState();
}

class _RodsScreenState extends State<RodsScreen> {
  List<Rod>? rods;
  String searchQuery = '';
  bool isAscending = true; // Флаг для сортировки
  String? role;
  getRods() async {
    rods = await RodRepository.getRods();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRole();
    getRods();
  }

  Future<void> _getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
  }

  /* @override
  void initState() {
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    // Фильтрация и сортировка списка
    List<Rod> filteredRods = rods?.where((rod) {
          return rod.name.toLowerCase().startsWith(searchQuery.toLowerCase());
        }).toList() ??
        [];

    if (isAscending) {
      filteredRods.sort((a, b) => a.price.compareTo(b.price));
    } else {
      filteredRods.sort((a, b) => b.price.compareTo(a.price));
    }

    return rods == null
        ? const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: const Text('Удилища'),
              centerTitle: true,
              backgroundColor: const Color(0xffffffff),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context,
                      '/main'); // Убедитесь, что маршрут '/login' определен
                },
              ),
              actions: [
                if (role != 'USER' && role != null)
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.blue),
                    onPressed: () {
                      Navigator.pushNamed(context, '/addRod');
                    },
                  ),
              ],
              /* automaticallyImplyLeading: false,
          leading: IconButton(
            
            icon: Icon(Icons.keyboard_arrow_left), // Иконка кнопки
            onPressed: () {
              Navigator.pushNamed(context,'/');
              print('Кнопка нажата');
            },
          ),*/
            ),
            body: Container(
              color: Color(0x1200CCFF),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        IconButton(
                          icon: Icon(isAscending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward),
                          onPressed: () {
                            setState(() {
                              isAscending =
                                  !isAscending; // Переключение порядка сортировки
                            });
                          },
                        ),
                        Text(
                          'Сортировка по цене',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value; // Обновляем поисковый запрос
                        });
                      },
                      decoration: InputDecoration(
                        filled: true, // Указываем, что фон будет залит
                        fillColor: Colors.white, // Цвет фона
                        hintText: 'Поиск по названию',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: role==null ? 0.65 : 0.55,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemCount: filteredRods
                          .length, // Используем отфильтрованный список
                      itemBuilder: (context, index) {
                        Rod rod = filteredRods[index]; // Получаем объект Rod
                        return RodTile(rod: rod,role: role);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
