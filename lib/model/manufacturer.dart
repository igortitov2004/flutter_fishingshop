// ignore_for_file: file_names

class Manufacturer {
  int id;
  String name;

  Manufacturer({
    required this.id,
    required this.name
  });
  
  factory Manufacturer.fromMap(Map manufacturerMap){
    return Manufacturer(
      id: manufacturerMap['id'],
      name: manufacturerMap['name'],
      );
  }
  Map<String, dynamic> toMap(Manufacturer manufacturer) {
    return {
      'id': manufacturer.id,
      'name': manufacturer.name,
    };
  }

}