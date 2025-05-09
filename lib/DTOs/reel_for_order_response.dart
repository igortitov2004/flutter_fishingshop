import 'package:fishingshop/model/reel.dart';

class ReelForOrderResponse{
  Reel reel;
  int amount;


  ReelForOrderResponse({
    required this.reel,
    required this.amount
  });

  factory ReelForOrderResponse.fromMap(Map reelOrderMap){
    return ReelForOrderResponse(
      reel: Reel.fromMap(reelOrderMap['reel']),
      amount: reelOrderMap['amount'],
      );
  }
}