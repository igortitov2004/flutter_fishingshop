import 'package:fishingshop/DTOs/rod_edit_request.dart';
import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/model/rod.dart';
import 'package:fishingshop/model/typeOfRod.dart';
import 'package:fishingshop/service/manufacturer_repository.dart';
import 'package:fishingshop/service/rod_repository.dart';
import 'package:flutter/material.dart';

class RodEditScreen extends StatefulWidget {
  const RodEditScreen({Key? key}) : super(key: key);

  @override
  _RodEditScreenState createState() => _RodEditScreenState();
}

class _RodEditScreenState extends State<RodEditScreen> {
  Rod? rod;
  int? selectedManufacturerId;
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    rod = args as Rod;
    
    super.didChangeDependencies();
  }

  List<Manufacturer>? manufacturers;
  List<TypeOfRod>? typesOfRod;
  getManufacturers() async {
    manufacturers = await ManufacturerRepository.getManufacturers();
    selectedManufacturerId = rod!.manufacturer.id;
    setState(() {});
  }

  

  @override
  void initState() {
    super.initState();
    getManufacturers();
  }

  final _formKey = GlobalKey<FormState>();
  late String name;
  late double price;
  late int manufacturerId =
      0; // Предполагается, что это будет выбранный производитель
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
              title: Text('Изменение удилища'),
              backgroundColor: Colors.white,
              /*automaticallyImplyLeading: false,
              leading: IconButton(
            
            icon: Icon(Icons.keyboard_arrow_left), // Иконка кнопки
            onPressed: () {
              Navigator.pushNamed(context,'/rodDetails');
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
                        initialValue: rod!.name,
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
                        initialValue: rod!.price.toString(),
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
                                color: selectedManufacturerId != null
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
                        initialValue: rod!.link,
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
                              selectedManufacturerId != 0) {
                            manufacturerId = selectedManufacturerId!;
                            _formKey.currentState!.save();
                            RodEditRequest request = RodEditRequest(
                              id: rod!.id,
                              name: name,
                              
                              price: price,
                              manufacturer: Manufacturer(
                                  id: manufacturerId,
                                  name:
                                      ""), // Здесь нужно получить выбранного производителя
                              link: link,
                            );

                            // Здесь можно сохранить новый объект Rod в базе данных или отправить на сервер
                            RodRepository.editRod(request);
                            Navigator.pushNamed(context, '/rods');
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
