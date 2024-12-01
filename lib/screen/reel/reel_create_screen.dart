import 'package:fishingshop/DTOs/reel_create_request.dart';
import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/model/typeOfReel.dart';
import 'package:fishingshop/screen/reel/reel_screen.dart';
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

  @override
  void initState() {
    super.initState();
    getManufacturers();
    getTypesOfReel();
  }

  Future<void> getManufacturers() async {
    manufacturers = await ManufacturerRepository.getManufacturers();
    setState(() {});
  }

  Future<void> getTypesOfReel() async {
    typesOfReel = await TypeOfReelRepository.getTypesOfReel();
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  late String name;
  late double price;
  late String link;

  void _showManufacturerMenu(BuildContext context) async {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RenderBox button = context.findRenderObject() as RenderBox;

    await showMenu<int>(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(
        button.localToGlobal(Offset.zero).dx,
        button.localToGlobal(Offset.zero).dy + 270,
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
                        child: Text(manufacturer.name,
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

  void _showTypeOfReelMenu(BuildContext context) async {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RenderBox button = context.findRenderObject() as RenderBox;

    await showMenu<int>(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(
        button.localToGlobal(Offset.zero).dx,
        button.localToGlobal(Offset.zero).dy + 340,
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
                  children: typesOfReel!.map<Widget>((TypeOfReel typeOfReel) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTypeOfReelId = typeOfReel.id;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(typeOfReel.type,
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
    return manufacturers == null || typesOfReel == null
        ? const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Добавление катушки'),
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context,
                      '/reels'); // Убедитесь, что маршрут '/login' определен
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
                        onTap: () => _showTypeOfReelMenu(context),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Тип',
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              selectedTypeOfReelId != null
                                  ? typesOfReel!
                                      .firstWhere(
                                          (t) => t.id == selectedTypeOfReelId)
                                      .type
                                  : 'Выберите тип',
                              style: TextStyle(
                                color: selectedTypeOfReelId != null
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
                              selectedTypeOfReelId != null) {
                            _formKey.currentState!.save();
                            ReelCreateRequest request = ReelCreateRequest(
                              name: name,
                              price: price,
                              typeId: selectedTypeOfReelId!,
                              manufacturerId: selectedManufacturerId!,
                              link: link,
                            );

                            // Здесь можно сохранить новый объект Reel в базе данных или отправить на сервер
                            ReelRepository.addReel(request, context);

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ReelsScreen()),
                                  (Route<dynamic> route)=>false,
                            );
                    
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
