import 'package:fishingshop/model/rod.dart';

class RodForOrderResponse{
  Rod rod;
  int amount;


  RodForOrderResponse({
    required this.rod,
    required this.amount
  });

  factory RodForOrderResponse.fromMap(Map rodOrderMap){
    return RodForOrderResponse(
      rod: Rod.fromMap(rodOrderMap['rod']),
      amount: rodOrderMap['amount'],
      );
  }
}