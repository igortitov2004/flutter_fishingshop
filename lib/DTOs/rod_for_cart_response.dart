import 'package:fishingshop/model/rod.dart';
class RodForCartResponse{
  int id;
  Rod rod;
  int amount;


  RodForCartResponse({
    required this.id,
    required this.rod,
    required this.amount
  });

  factory RodForCartResponse.fromMap(Map rodCartMap){
    return RodForCartResponse(
      id: rodCartMap['id'],
      rod: Rod.fromMap(rodCartMap['rod']),
      amount: rodCartMap['amount'],
      );
  }
}