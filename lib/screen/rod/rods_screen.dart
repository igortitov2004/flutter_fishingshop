import 'package:fishingshop/model/rod.dart';

import 'package:fishingshop/tiles/rod_tile.dart';
import 'package:fishingshop/service/rod_repository.dart';
import 'package:flutter/material.dart';

class RodsScreen extends StatefulWidget {
  const RodsScreen({Key? key}) : super(key: key);

  @override
  _RodsScreenState createState() => _RodsScreenState();
}

class _RodsScreenState extends State<RodsScreen> {
  List<Rod>? rods;
  String searchQuery = '';
  bool isAscending = true; // Флаг для сортировки

  getRods() async {
    rods = await RodRepository.getRods();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getRods();
  }

  @override
  Widget build(BuildContext context) {
    // Фильтрация и сортировка списка
    List<Rod> filteredRods = rods?.where((rod) {
          return rod.name.toLowerCase().startsWith(searchQuery.toLowerCase());
        }).toList() ??
        [];

    if (isAscending) {
      filteredRods.sort((a, b) => a.name.compareTo(b.name));
    } else {
      filteredRods.sort((a, b) => b.name.compareTo(a.name));
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
              title: const Text('solo'),
              centerTitle: true,
              backgroundColor: const Color(0xffffffff),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/addRod');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.add, color: Colors.blue),
                              SizedBox(width: 8),
                              Text(
                                'Добавить удилище',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemCount: filteredRods
                          .length, // Используем отфильтрованный список
                      itemBuilder: (context, index) {
                        Rod rod = filteredRods[index]; // Получаем объект Rod
                        return RodTile(rod: rod);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
