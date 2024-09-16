class ReelCreateRequest{
  String name;
  double price;
  int typeId;
  int manufacturerId;
  String link;

  ReelCreateRequest({
    required this.name,
    required this.price,
    required this.typeId,
    required this.manufacturerId,
    required this.link,
  });

    Map<String, dynamic> toMap(ReelCreateRequest request) {
    return {
      "name": request.name,
      "price": request.price,
      "typeId": request.typeId, 
      "manufacturerId": request.manufacturerId, 
      "link": link,
    };
  }
}