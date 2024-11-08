import 'package:fishingshop/DTOs/rod_create_request.dart';
import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/model/typeOfRod.dart';
import 'package:fishingshop/service/manufacturer_repository.dart';
import 'package:fishingshop/service/rod_repository.dart';
import 'package:fishingshop/service/type_of_rod_repository.dart';
import 'package:flutter/material.dart';

class RodCreateScreen extends StatefulWidget {
  const RodCreateScreen({Key? key}) : super(key: key);

  @override
  _RodCreateScreenState createState() => _RodCreateScreenState();
}

class _RodCreateScreenState extends State<RodCreateScreen> {
  int? selectedManufacturerId;
  int? selectedTypeOfRodId;
  List<Manufacturer>? manufacturers;
  List<TypeOfRod>? typesOfRod;

  @override
  void initState() {
    super.initState();
    getManufacturers();
    getTypesOfRod();
  }

  Future<void> getManufacturers() async {
    manufacturers = await ManufacturerRepository.getManufacturers();
    setState(() {});
  }

  Future<void> getTypesOfRod() async {
    typesOfRod = await TypeOfRodRepository.getTypesOfRod();
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  late String name;
  late int length;
  late int weight;
  late int testLoad;
  late double price;
  late int typeId = 0;
  late int manufacturerId = 0;
  late String link;

  void _showManufacturerMenu(BuildContext context) async {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RenderBox button =
        context.findRenderObject() as RenderBox; // Получаем позицию кнопки

    await showMenu<int>(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(
        button.localToGlobal(Offset.zero).dx,
        button.localToGlobal(Offset.zero).dy + 170, // Позиция над кнопкой
        button.localToGlobal(Offset.zero).dx + button.size.width,
        button.localToGlobal(Offset.zero).dy,
      ),
      items: [
        PopupMenuItem<int>(
          enabled: false,
          child: Container(
            height: 200, // Фиксированная высота для списка
            width: 300,
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Column(
                  children:
                      manufacturers!.map<Widget>((Manufacturer manufacturer) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedManufacturerId = manufacturer.id;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          manufacturer.name,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  void _showTypeOfRodMenu(BuildContext context) async {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RenderBox button =
        context.findRenderObject() as RenderBox; // Получаем позицию кнопки

    await showMenu<int>(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(
        button.localToGlobal(Offset.zero).dx,
        button.localToGlobal(Offset.zero).dy + 240, // Позиция над кнопкой
        button.localToGlobal(Offset.zero).dx + button.size.width,
        button.localToGlobal(Offset.zero).dy,
      ),
      items: [
        PopupMenuItem<int>(
          enabled: false,
          child: Container(
            height: 200, // Фиксированная высота для списка
            width: 300,
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Column(
                  children: typesOfRod!.map<Widget>((TypeOfRod typeOfRod) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTypeOfRodId = typeOfRod.id;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(typeOfRod.type,
                            style: TextStyle(color: Colors.black)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return manufacturers == null || typesOfRod == null
        ? const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Добавление удилища'),
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context,
                      '/rods'); // Убедитесь, что маршрут '/login' определен
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Название'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите название';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          name = value!;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Длина'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите длину';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          length = int.parse(value!);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Вес'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите вес';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          weight = int.parse(value!);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Нагрузочная способность'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите нагрузочную способность';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          testLoad = int.parse(value!);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Цена'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите цену';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          price = double.parse(value!);
                        },
                      ),
                      GestureDetector(
                        onTap: () => _showManufacturerMenu(context),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Производитель',
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              selectedManufacturerId != null
                                  ? manufacturers!
                                      .firstWhere(
                                          (m) => m.id == selectedManufacturerId)
                                      .name
                                  : 'Выберите производителя',
                              style: TextStyle(
                                color: selectedManufacturerId != null
                                    ? Colors.black
                                    : Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showTypeOfRodMenu(context),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Тип',
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              selectedTypeOfRodId != null
                                  ? typesOfRod!
                                      .firstWhere(
                                          (t) => t.id == selectedTypeOfRodId)
                                      .type
                                  : 'Выберите тип',
                              style: TextStyle(
                                color: selectedTypeOfRodId != null
                                    ? Colors.black
                                    : Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Ссылка'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите ссылку';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          link = value!;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              selectedManufacturerId != null &&
                              selectedTypeOfRodId != null) {
                            manufacturerId = selectedManufacturerId!;
                            typeId = selectedTypeOfRodId!;
                            _formKey.currentState!.save();
                            RodCreateRequest request = RodCreateRequest(
                              name: name,
                              length: length,
                              weight: weight,
                              testLoad: testLoad,
                              price: price,
                              typeId: typeId,
                              manufacturerId: manufacturerId,
                              link: link,
                            );

                            // Здесь можно сохранить новый объект Rod в базе данных или отправить на сервер
                            RodRepository.addRod(request);
                            Navigator.pop(context,true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Сохранить',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
