import 'package:fishingshop/model/reel.dart';
import 'package:fishingshop/service/reel_repository.dart';
import 'package:fishingshop/tiles/reel_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({Key? key}) : super(key: key);

  @override
  _ReelsScreenState createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  List<Reel>? reels;
  String searchQuery = '';
  bool isAscending = true; // Флаг для сортировки
  String? role;

  getReels() async {
    reels = await ReelRepository.getReels();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getRole();
    getReels();
  }

  Future<void> _getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Фильтрация и сортировка списка
    List<Reel> filteredReels = reels?.where((reel) {
          return reel.name.toLowerCase().startsWith(searchQuery.toLowerCase());
        }).toList() ??
        [];

    if (isAscending) {
      filteredReels.sort((a, b) => a.price.compareTo(b.price));
    } else {
      filteredReels.sort((a, b) => b.price.compareTo(a.price));
    }

    return reels == null
        ? const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: const Text('Катушки'),
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
                      Navigator.pushNamed(context, '/addReel');
                    },
                  ),
              ],
              /*automaticallyImplyLeading: false,
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
                        childAspectRatio: role==null ? 0.7 : 0.6,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemCount: filteredReels
                          .length, // Используем отфильтрованный список
                      itemBuilder: (context, index) {
                        Reel reel = filteredReels[index]; // Получаем объект Rod
                        return ReelTile(reel: reel,role: role);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
