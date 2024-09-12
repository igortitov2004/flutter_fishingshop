import 'package:fishingshop/model/manufacturer.dart';

class Rod{
  int id;
  String name;
  int length;
  int weight;
  int testLoad;
  double price;
  //TypeOfRodDTO type;
  Manufacturer manufacturer;
  String link;

  Rod({
    required this.id,
    required this.name,
    required this.length,
    required this.weight,
    required this.testLoad,
    required this.price,
    required this.manufacturer,
    required this.link,
  });

  factory Rod.fromMap(Map rodMap){
    return Rod(
      id: rodMap['id'],
      name: rodMap['name'],
      length: rodMap['length'],
      weight: rodMap['weight'],
      testLoad: rodMap['testLoad'],
      price: rodMap['price'],
      manufacturer: Manufacturer.fromMap(rodMap['manufacturer']),
      link: rodMap['link']
      );
  }



}