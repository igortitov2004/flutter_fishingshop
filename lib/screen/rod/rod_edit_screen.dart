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

  void _showManufacturerMenu(BuildContext context) async {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
         final RenderBox button = context.findRenderObject() as RenderBox;

    await showMenu<int>(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(
        button.localToGlobal(Offset.zero).dx,
        button.localToGlobal(Offset.zero).dy + 270, // Позиция над кнопкой
        button.localToGlobal(Offset.zero).dx + button.size.width,
        button.localToGlobal(Offset.zero).dy,
      ),
      items: [
        PopupMenuItem<int>(
          enabled: false,
          child: Container(
            height: 200,
            width: 300,
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Column(
                  children: manufacturers!.map<Widget>((Manufacturer manufacturer) {
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
                        child: Text(manufacturer.name, style: TextStyle(color: Colors.black)),
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

                      GestureDetector(
                        onTap: () => _showManufacturerMenu(context),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Производитель',
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Text(
                              selectedManufacturerId != null
                                  ? manufacturers!.firstWhere((m) => m.id == selectedManufacturerId).name
                                  : 'Выберите производителя',
                              style: TextStyle(
                                color: selectedManufacturerId != null ? Colors.black : Colors.red,
                                fontSize: 16,
                              ),
                            ),
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
