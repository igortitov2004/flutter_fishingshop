import 'package:fishingshop/DTOs/reel_for_order_response.dart';
import 'package:fishingshop/DTOs/rod_for_order_response.dart';

class OrderResponse {
  final int id;
  final List<ReelForOrderResponse> reelsForOrderResponseList;
  final List<RodForOrderResponse> rodsForOrderResponseList;
  final double totalPrice;
  final String localDateTime;
  final String address;

  OrderResponse({
    required this.id,
    required this.reelsForOrderResponseList,
    required this.rodsForOrderResponseList,
    required this.totalPrice,
    required this.localDateTime,
    required this.address,
  });
factory OrderResponse.fromMap(Map<String, dynamic> orderMap) {
    var reelList = (orderMap['reelsForOrderResponseList'] as List<dynamic>?)
        ?.map((reel) => ReelForOrderResponse.fromMap(reel as Map<String, dynamic>))
        .toList() ?? []; 

    var rodList = (orderMap['rodsForOrderResponseList'] as List<dynamic>?)
        ?.map((rod) => RodForOrderResponse.fromMap(rod as Map<String, dynamic>))
        .toList() ?? []; 
    return OrderResponse(
      id: orderMap['id'],
      reelsForOrderResponseList: reelList,
      rodsForOrderResponseList: rodList,
      totalPrice: (orderMap['totalPrice'] as num?)?.toDouble() ?? 0.0,
      localDateTime: orderMap['localDateTime'] ?? '',
      address: orderMap['address'] ?? '',
    );
  }
}
