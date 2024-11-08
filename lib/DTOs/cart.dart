import 'package:fishingshop/DTOs/reel_for_cart_response.dart';
import 'package:fishingshop/DTOs/rod_for_cart_response.dart';
class Cart{
    List<ReelForCartResponse> reelForCartResponseList;
    List<RodForCartResponse> rodForCartResponseList;
    double totalPrice;


  Cart({
    required this.reelForCartResponseList,
    required this.rodForCartResponseList,
    required this.totalPrice
  });

 factory Cart.fromMap(Map<String, dynamic> cartMap) {
    // Проверка и преобразование списка reelForCartResponseList
    var reelList = (cartMap['reelForCartResponseList'] as List<dynamic>?)
        ?.map((reel) => ReelForCartResponse.fromMap(reel as Map<String, dynamic>))
        .toList() ?? []; // Пустой список по умолчанию

    // Проверка и преобразование списка rodForCartResponseList
    var rodList = (cartMap['rodForCartResponseList'] as List<dynamic>?)
        ?.map((rod) => RodForCartResponse.fromMap(rod as Map<String, dynamic>))
        .toList() ?? []; // Пустой список по умолчанию

    return Cart(
      reelForCartResponseList: reelList,
      rodForCartResponseList: rodList,
      totalPrice: (cartMap['totalPrice'] as num?)?.toDouble() ?? 0.0, // Значение по умолчанию
    );
  }
}