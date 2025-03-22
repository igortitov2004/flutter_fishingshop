import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/model/rod_comment.dart';
import 'package:fishingshop/model/typeOfRod.dart';

class Rod{
  int id;
  String name;
  int length;
  int weight;
  int testLoad;
  double price;
  TypeOfRod type;
  Manufacturer manufacturer;
  String link;
  List<RodComment> rodComments;
  int? commentsAmount;
  double rating;
  int amount;

  Rod({
    required this.id,
    required this.name,
    required this.length,
    required this.weight,
    required this.testLoad,
    required this.price,
    required this.type,
    required this.manufacturer,
    required this.link,
    required this.rodComments,
    required this.commentsAmount,
    required this.rating,
    required this.amount
  });

  factory Rod.fromMap(Map rodMap){
    var rodCommentList = (rodMap['rodCommentsList'] as List<dynamic>?)
        ?.map((reel) => RodComment.fromMap(reel as Map<String, dynamic>))
        .toList() ?? []; // Пустой список по умолчанию
    return Rod(
      id: rodMap['id'],
      name: rodMap['name'],
      length: rodMap['length'],
      weight: rodMap['weight'],
      testLoad: rodMap['testLoad'],
      price: rodMap['price'],
      type: TypeOfRod.fromMap(rodMap['type']),
      manufacturer: Manufacturer.fromMap(rodMap['manufacturer']),
      link: rodMap['link'],
      rodComments: rodCommentList,
      commentsAmount: rodMap['commentsAmount'],
      rating: rodMap['rating'],
      amount: rodMap['amount']
      );
  }
    Map<String, dynamic> toMap(Rod rod) {
    return {
      "name": rod.name,
      "length": rod.length,
      "weight": rod.weight,
      "testLoad": rod.testLoad,
      "price": rod.price,
      "typeId": rod.type.id, // Предполагается, что у TypeOfRod есть метод toMap
      "manufacturerId": rod.manufacturer.id, // Предполагается, что у Manufacturer есть метод toMap
      "link": link,
    };
  }



}