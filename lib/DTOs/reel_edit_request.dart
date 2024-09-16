class ReelEditRequest{
  int id;
  String name;
  double price;
  int manufacturerId;
  String link;

  ReelEditRequest({
    required this.id,
    required this.name,
    required this.price,
    required this.manufacturerId,
    required this.link,
  });

    Map<String, dynamic> toMap(ReelEditRequest request) {
    return {
      "id": request.id,
      "name": request.name,
      "price": request.price,
      "manufacturerId": request.manufacturerId, 
      "link": link,
    };
  }
}