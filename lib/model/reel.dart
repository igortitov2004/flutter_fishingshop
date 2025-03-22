

import 'package:fishingshop/model/manufacturer.dart';
import 'package:fishingshop/model/reel_comment.dart';
import 'package:fishingshop/model/typeOfReel.dart';

class Reel{
  int id;
  String name;
  double price;
  TypeOfReel type;
  Manufacturer manufacturer;
  String link;
  List<ReelComment> reelComments;
  int? commentsAmount;
  double rating;
  int amount;

  Reel({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.manufacturer,
    required this.link,
    required this.reelComments,
    required this.commentsAmount,
    required this.rating,
    required this.amount
  });

    factory Reel.fromMap(Map reelMap){
      var reelCommentList = (reelMap['reelCommentsList'] as List<dynamic>?)
        ?.map((reel) => ReelComment.fromMap(reel as Map<String, dynamic>))
        .toList() ?? []; // Пустой список по умолчанию
    return Reel(
      id: reelMap['id'],
      name: reelMap['name'],
      price: reelMap['price'],
      type: TypeOfReel.fromMap(reelMap['type']),
      manufacturer: Manufacturer.fromMap(reelMap['manufacturer']),
      link: reelMap['link'],
      reelComments: reelCommentList,
      commentsAmount: reelMap['commentsAmount'],
      rating: reelMap['rating'],
      amount: reelMap['amount']
      );
  }
}