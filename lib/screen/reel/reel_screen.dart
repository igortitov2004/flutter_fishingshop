import 'package:fishingshop/model/reel.dart';
import 'package:fishingshop/service/reel_repository.dart';
import 'package:fishingshop/tiles/reel_tile.dart';
import 'package:flutter/material.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({Key? key}) : super(key: key);

  @override
  _ReelsScreenState createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  List<Reel>? reels;
  String searchQuery = '';
  bool isAscending = true; // Флаг для сортировки

  getReels() async {
    reels = await ReelRepository.getReels();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getReels();
  }

  @override
  Widget build(BuildContext context) {
    // Фильтрация и сортировка списка
    List<Reel> filteredReels = reels?.where((reel) {
          return reel.name.toLowerCase().startsWith(searchQuery.toLowerCase());
        }).toList() ??
        [];

    if (isAscending) {
      filteredReels.sort((a, b) => a.name.compareTo(b.name));
    } else {
      filteredReels.sort((a, b) => b.name.compareTo(a.name));
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
              title: const Text('solo'),
              centerTitle: true,
              backgroundColor: const Color(0xffffffff),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                           Navigator.pushNamed(context, '/addReel');
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
                                'Добавить катушку',
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
                      itemCount: filteredReels
                          .length, // Используем отфильтрованный список
                      itemBuilder: (context, index) {
                        Reel reel = filteredReels[index]; // Получаем объект Rod
                        return ReelTile(reel: reel);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}