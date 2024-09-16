import 'package:fishingshop/DTOs/reel_create_request.dart';
import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/model/typeOfReel.dart';
import 'package:fishingshop/service/manufacturer_repository.dart';
import 'package:fishingshop/service/reel_repository.dart';
import 'package:fishingshop/service/type_of_reel_repository.dart';
import 'package:flutter/material.dart';

class ReelCreateScreen extends StatefulWidget {
  const ReelCreateScreen({Key? key}) : super(key: key);

  @override
  _ReelCreateScreenState createState() => _ReelCreateScreenState();
}

class _ReelCreateScreenState extends State<ReelCreateScreen> {
  int? selectedManufacturerId;
  int? selectedTypeOfReelId;
  List<Manufacturer>? manufacturers;
  List<TypeOfReel>? typesOfReel;
  getManufacturers() async {
    manufacturers = await ManufacturerRepository.getManufacturers();
    setState(() {});
  }

  getTypesOfRod() async {
    typesOfReel = await TypeOfReelRepository.getTypesOfReel();
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
  late double price;
  late int typeId = 0; // Предполагается, что это будет выбранный тип
  late int manufacturerId = 0; // Предполагается, что это будет выбранный производитель
  late String link;

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
           backgroundColor: Colors.white,
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: Text('Добавление катушки'),
              backgroundColor: Colors.white,
             /* automaticallyImplyLeading: false,
          leading: IconButton(
            
            icon: Icon(Icons.keyboard_arrow_left), // Иконка кнопки
            onPressed: () {
              Navigator.pushNamed(context,'/reels');
              print('Кнопка нажата');
            },
          ),*/
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
                            value: selectedTypeOfReelId,
                            onChanged: (int? newValue) {
                              setState(() {
                                selectedTypeOfReelId = newValue;
                              });
                            },
                            items: typesOfReel!.map<DropdownMenuItem<int>>(
                                (TypeOfReel typeOfReel) {
                              return DropdownMenuItem<int>(
                                value: typeOfReel.id,
                                child: Text(typeOfReel.type),
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
                              selectedTypeOfReelId != 0) {
                            manufacturerId = selectedManufacturerId!;
                            typeId = selectedTypeOfReelId!;
                            _formKey.currentState!.save();
                            ReelCreateRequest request = ReelCreateRequest(
                              name: name,
                              price: price,
                              typeId: typeId, // Здесь нужно получить выбранный тип
                              manufacturerId: manufacturerId, // Здесь нужно получить выбранного производителя
                              link: link,
                            );

                            // Здесь можно сохранить новый объект Rod в базе данных или отправить на сервер
                            ReelRepository.addReel(request);
                            Navigator.pushNamed(context, '/reels');
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