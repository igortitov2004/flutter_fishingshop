

class TypeOfRod{
  int id;
  String type;

  TypeOfRod({
    required this.id,
    required this.type
  });

  factory TypeOfRod.fromMap(Map typeOfRodMap){
    return TypeOfRod(
      id: typeOfRodMap['id'],
      type: typeOfRodMap['type']
      );
  }
  Map<String, dynamic> toMap(TypeOfRod typeOfRod) {
    return {
      'id': typeOfRod.id,
      'type': typeOfRod.type,
    };
  }
}