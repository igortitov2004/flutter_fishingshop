import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/model/typeOfReel.dart';

class Reel{
  int id;
  String name;
  double price;
  TypeOfReel type;
  Manufacturer manufacturer;
  String link;

  Reel({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.manufacturer,
    required this.link,
  });

    factory Reel.fromMap(Map reelMap){
    return Reel(
      id: reelMap['id'],
      name: reelMap['name'],
      price: reelMap['price'],
      type: TypeOfReel.fromMap(reelMap['type']),
      manufacturer: Manufacturer.fromMap(reelMap['manufacturer']),
      link: reelMap['link']
      );
  }
}