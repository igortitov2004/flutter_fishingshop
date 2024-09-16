import 'package:fishingshop/model/manufacturer.dart';

class RodEditRequest{
  int id;
  String name;
  double price;
  Manufacturer manufacturer;
  String link;

  RodEditRequest({
    required this.id,
    required this.name,
    required this.price,
    required this.manufacturer,
    required this.link,
  });

  
    Map<String, dynamic> toMap(RodEditRequest rod) {
    return {
      "id":rod.id,
      "name": rod.name,
      "price": rod.price,
      "manufacturerId": rod.manufacturer.id, // Предполагается, что у Manufacturer есть метод toMap
      "link": link,
    };
  }



}