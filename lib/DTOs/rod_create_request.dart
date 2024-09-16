class RodCreateRequest{
  String name;
  int length;
  int weight;
  int testLoad;
  double price;
  int typeId;
  int manufacturerId;
  String link;

  RodCreateRequest({
    required this.name,
    required this.length,
    required this.weight,
    required this.testLoad,
    required this.price,
    required this.typeId,
    required this.manufacturerId,
    required this.link,
  });

    Map<String, dynamic> toMap(RodCreateRequest request) {
    return {
      "name": request.name,
      "length": request.length,
      "weight": request.weight,
      "testLoad": request.testLoad,
      "price": request.price,
      "typeId": request.typeId, 
      "manufacturerId": request.manufacturerId, 
      "link": link,
    };
  }



}