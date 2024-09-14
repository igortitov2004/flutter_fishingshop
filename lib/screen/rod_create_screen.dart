import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/model/rod.dart';
import 'package:fishingshop/model/typeOfRod.dart';
import 'package:fishingshop/service/api_service.dart';
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
  getManufacturers() async {
    manufacturers = await ApiService.getManufacturers();
    setState(() {});
  }

  getTypesOfRod() async {
    typesOfRod = await ApiService.getTypesOfRod();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getManufacturers();
    getTypesOfRod();
  }

  final _formKey = GlobalKey<FormState>();
  late String name;
  late int length;
  late int weight;
  late int testLoad;
  late double price;
  late int typeId = 0; // Предполагается, что это будет выбранный тип
  late int manufacturerId =
      0; // Предполагается, что это будет выбранный производитель
  late String link;

  @override
  Widget build(BuildContext context) {
    return manufacturers == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Добавление удилища'),
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
                            return '';
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
                            return '';
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
                            return '';
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
                            return '';
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
                            return '';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          price = double.parse(value!);
                        },
                      ),

                      InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Производитель',
                          // Добавьте рамку для визуального оформления
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            menuWidth: 300,
                            hint: Text(
                              'Выберите производителя',
                              style: TextStyle(
                                color: manufacturerId != 0
                                    ? Colors.black
                                    : Colors.red,
                                fontSize: 16,
                              ),
                            ),
                            value: selectedManufacturerId,
                            onChanged: (int? newValue) {
                              setState(() {
                                selectedManufacturerId = newValue;
                              });
                            },
                            items: manufacturers!.map<DropdownMenuItem<int>>(
                                (Manufacturer manufacturer) {
                              return DropdownMenuItem<int>(
                                value: manufacturer.id,
                                child: Text(manufacturer.name),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Тип',
                          // Добавьте рамку для визуального оформления
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            menuWidth: 300,
                            hint: Text(
                              'Выберите тип',
                              style: TextStyle(
                                color: typeId != 0 ? Colors.black : Colors.red,
                                fontSize: 16,
                              ),
                            ),
                            value: selectedTypeOfRodId,
                            onChanged: (int? newValue) {
                              setState(() {
                                selectedTypeOfRodId = newValue;
                              });
                            },
                            items: typesOfRod!.map<DropdownMenuItem<int>>(
                                (TypeOfRod typeOfRod) {
                              return DropdownMenuItem<int>(
                                value: typeOfRod.id,
                                child: Text(typeOfRod.type),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      /*Text(
                        selectedManufacturerId != null
                            ? 'Selected Manufacturer ID: $selectedManufacturerId'
                            : 'No manufacturer selected',
                        style: TextStyle(fontSize: 16),
                      ),

                      SizedBox(height: 20),
                      Text(
                        selectedManufacturerId != null
                            ? 'Selected: $selectedManufacturerId'
                            : 'No option selected',
                        style: TextStyle(fontSize: 16),
                      ),*/

                      // Здесь можно добавить выбор типа удилища и производителя

                      // Например, используя DropdownButton или другой виджет

                      TextFormField(
                        decoration: InputDecoration(labelText: 'Ссылка'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
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
                              selectedManufacturerId != 0 &&
                              selectedTypeOfRodId != 0) {
                            manufacturerId = selectedManufacturerId!;
                            typeId = selectedTypeOfRodId!;
                            _formKey.currentState!.save();
                            Rod newRod = Rod(
                              id: 0,
                              name: name,
                              length: length,
                              weight: weight,
                              testLoad: testLoad,
                              price: price,
                              type: TypeOfRod(
                                  id: typeId,
                                  type:
                                      ""), // Здесь нужно получить выбранный тип
                              manufacturer: Manufacturer(
                                  id: manufacturerId,
                                  name:
                                      ""), // Здесь нужно получить выбранного производителя
                              link: link,
                            );

                            // Здесь можно сохранить новый объект Rod в базе данных или отправить на сервер
                            ApiService.addRod(newRod);
                            Navigator.pushNamed(context, '/');
                            // Закрыть страницу после сохранения
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
