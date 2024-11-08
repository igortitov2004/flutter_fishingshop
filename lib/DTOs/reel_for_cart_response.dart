import 'package:fishingshop/model/reel.dart';
class ReelForCartResponse{
  int id;
  Reel reel;
  int amount;


  ReelForCartResponse({
    required this.id,
    required this.reel,
    required this.amount
  });

  factory ReelForCartResponse.fromMap(Map reelCartMap){
    return ReelForCartResponse(
      id: reelCartMap['id'],
      reel: Reel.fromMap(reelCartMap['reel']),
      amount: reelCartMap['amount'],
      );
  }
}