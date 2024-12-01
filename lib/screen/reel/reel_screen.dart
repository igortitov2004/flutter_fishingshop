import 'package:fishingshop/model/reel.dart';
import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/service/reel_repository.dart';
import 'package:fishingshop/service/manufacturer_repository.dart';
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
  List<Manufacturer>? manufacturers;
  String searchQuery = '';
  bool isAscending = true; // Флаг для сортировки
  String? role;
  List<String> selectedManufacturers = []; // Для хранения выбранных производителей

  @override
  void initState() {
    super.initState();
    _getRole();
    getReels();
    getManufacturers();
  }

  Future<void> getReels() async {
    reels = await ReelRepository.getReels();
    setState(() {});
  }

  Future<void> getManufacturers() async {
    manufacturers = await ManufacturerRepository.getManufacturers();
    setState(() {});
  }

  Future<void> _getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
  }

  void _toggleManufacturer(String manufacturer) {
    setState(() {
      if (selectedManufacturers.contains(manufacturer)) {
        selectedManufacturers.remove(manufacturer);
      } else {
        selectedManufacturers.add(manufacturer);
      }
    });
  }

  void _clearSelectedManufacturers() {
    setState(() {
      selectedManufacturers.clear(); // Очищаем список выбранных производителей
    });
  }

  void _sortReels(String criterion) {
    setState(() {
      if (criterion == 'price') {
        isAscending = true; // Сортировка по возрастанию
        reels?.sort((a, b) => a.price.compareTo(b.price));
      } else if (criterion == 'name') {
        isAscending = true; // Сортировка по возрастанию
        reels?.sort((a, b) => a.name.compareTo(b.name));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Фильтрация списка
    List<Reel> filteredReels = (reels ?? []).where((reel) {
      return reel.name.toLowerCase().startsWith(searchQuery.toLowerCase()) &&
          (selectedManufacturers.isEmpty || selectedManufacturers.contains(reel.manufacturer.name));
    }).toList();

    return reels == null || manufacturers == null
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
                  Navigator.pushNamed(context, '/main');
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
                PopupMenuButton<String>(
                  color: Colors.white,
                  icon: Icon(Icons.more_vert, color: Colors.black),
                  onSelected: _sortReels,
                  offset: Offset(0, 40),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'price',
                        child: Text('Сортировать по цене'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'name',
                        child: Text('Сортировать по названию'),
                      ),
                    ];
                  },
                ),
              ],
            ),
            body: Container(
              color: Color(0x1200CCFF),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Row(
                      children: [
                        const SizedBox(width: 4),
                        Expanded(
                          
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value; // Обновляем поисковый запрос
                              });
                            },
                            decoration: InputDecoration(
                              
                              hintText: 'Поиск по названию',
                              
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.filter_list, color: Colors.black),
                          onPressed: () => _showManufacturerMenu(context),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: role == null ? 0.65 : 0.58,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemCount: filteredReels.length,
                      itemBuilder: (context, index) {
                        Reel reel = filteredReels[index];
                        return ReelTile(reel: reel, role: role);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void _showManufacturerMenu(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Выберите производителей', style: const TextStyle(fontSize: 20)),
          content: SizedBox(
            height: 300,
            width: 300,
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView(
                children: manufacturers!.map<Widget>((Manufacturer manufacturer) {
                  return StatefulBuilder(
                    builder: (context, innerSetState) {
                      return CheckboxListTile(
                        title: Text(manufacturer.name),
                        value: selectedManufacturers.contains(manufacturer.name),
                        onChanged: (bool? value) {
                          _toggleManufacturer(manufacturer.name);
                          innerSetState(() {}); // Обновляем состояние внутри StatefulBuilder
                        },
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _clearSelectedManufacturers(); // Очищаем выбранные производители
                Navigator.of(context).pop(); // Закрываем диалог после очистки
                _showManufacturerMenu(context); // Открываем диалог снова для обновления состояния
              },
              child: Text('ОЧИСТИТЬ'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрываем диалог
              },
              child: Text('ЗАКРЫТЬ'),
            ),
          ],
        );
      },
    );
  }
}