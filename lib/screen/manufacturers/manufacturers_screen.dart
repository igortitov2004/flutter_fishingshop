import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/service/manufacturer_repository.dart';
import 'package:flutter/material.dart';

class ManufacturersScreen extends StatefulWidget {
  const ManufacturersScreen({Key? key}) : super(key: key);

  @override
  _ManufacturersScreenState createState() => _ManufacturersScreenState();
}

class _ManufacturersScreenState extends State<ManufacturersScreen> {
  List<Manufacturer>? manufacturers;

  Future<void> getManufacturers() async {
    manufacturers = await ManufacturerRepository.getManufacturers();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getManufacturers();
  }

  Future<void> _addManufacturer(String name) async {
    await ManufacturerRepository.addManufacturer(name,context);
    // Логика для добавления производителя
    getManufacturers();
  }
  Future<void> _editManufacturer(int id,String name) async {
    await ManufacturerRepository.editManufacturer(id,name,context);
    // Логика для добавления производителя
    getManufacturers();
  }

  @override
  Widget build(BuildContext context) {
    return manufacturers == null
        ? const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: const Text('Производители'),
              centerTitle: true,
              backgroundColor: const Color(0xffffffff),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.blue),
                  onPressed: () {
                    TextEditingController manufacturerController =
                        TextEditingController();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Добавление производителя',
                            style: TextStyle(fontSize: 18),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                controller: manufacturerController,
                                maxLength: 20,
                                decoration: InputDecoration(
                                    labelText: 'Имя производителя',
                                    counterText: 'Макс. 20 символов'),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Отмена'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text('Сохранить'),
                              onPressed: () {
                                String manufacturerName =
                                    manufacturerController.text;
                                if (manufacturerName.isNotEmpty) {
                                  _addManufacturer(manufacturerName);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            body: Container(
              width: double.infinity,
              color: const Color(0x1200CCFF), // Цвет фона
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Два элемента в строке
                  childAspectRatio: 3, // Соотношение сторон
                  crossAxisSpacing: 2, // Промежуток между колонками
                  mainAxisSpacing: 2, // Промежуток между строками
                ),
                itemCount: manufacturers!.length,
                itemBuilder: (context, index) {
                  Manufacturer manufacturer = manufacturers![index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(
                        manufacturer.name,
                        textAlign: TextAlign.center,
                      ),
                      onLongPress: () {
                        TextEditingController manufacturerController =
                        TextEditingController();
                        manufacturerController.text = manufacturers![index].name;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Изменение производителя',
                            style: TextStyle(fontSize: 18),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                controller: manufacturerController,
                                maxLength: 20,
                                decoration: InputDecoration(
                                    labelText: 'Имя производителя',
                                    counterText: 'Макс. 20 символов'),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Отмена'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text('Сохранить'),
                              onPressed: () {
                                String manufacturerName =
                                    manufacturerController.text;
                                if (manufacturerName.isNotEmpty) {
                                  _editManufacturer(manufacturers![index].id,manufacturerName);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                      },
                    ),
                  );
                },
              ),
            ),
          );
  }
}
