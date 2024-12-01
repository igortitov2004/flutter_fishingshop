import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/model/rod.dart';
import 'package:fishingshop/service/manufacturer_repository.dart';
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
  List<Manufacturer>? manufacturers;
  String searchQuery = '';
  bool isAscending = true; // Флаг для сортировки
  String? role;
  List<String> selectedManufacturers = []; // Для хранения выбранных производителей
  final ScrollController _scrollController = ScrollController(); // Создаем контроллер

  @override
  void initState() {
    super.initState();
    _getRole();
    getRods();
    getManufacturers();
  }

  Future<void> getRods() async {
    rods = await RodRepository.getRods(); 
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

  void _sortRods(String criterion) {
    if (rods != null) {
      setState(() {
        if (criterion == 'price') {
          rods!.sort((a, b) => isAscending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
        } else if (criterion == 'name') {
          rods!.sort((a, b) => isAscending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
        }
      });
    }
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

  @override
  void dispose() {
    _scrollController.dispose(); // Освобождаем контроллер
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Фильтрация списка
    List<Rod> filteredRods = (rods ?? []).where((rod) {
      return rod.name.toLowerCase().startsWith(searchQuery.toLowerCase()) &&
          (selectedManufacturers.isEmpty || selectedManufacturers.contains(rod.manufacturer.name));
    }).toList();

    return (rods == null || manufacturers == null)
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
                  Navigator.pushNamed(context, '/main');
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
                PopupMenuButton<String>(
                  color: Colors.white,
                  icon: Icon(Icons.more_vert, color: Colors.black),
                  onSelected: (value) {
                    _sortRods(value);
                  },
                  offset: Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem<String>(
                      value: 'price',
                      child: Text('Сортировать по цене'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'name',
                      child: Text('Сортировать по названию'),
                    ),
                  ],
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
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.filter_list, color: Colors.black),
                          onPressed: () => _showManufacturerMenu(context),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController, // Передаем контроллер
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: role == null ? 0.65 : 0.55,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemCount: filteredRods.length,
                      itemBuilder: (context, index) {
                        Rod rod = filteredRods[index];
                        return RodTile(rod: rod, role: role);
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
          title: Text('Выберите производителей',
          style: const TextStyle(fontSize: 20),),
          content: SizedBox(
            height: 300,
            width: 300,
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
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