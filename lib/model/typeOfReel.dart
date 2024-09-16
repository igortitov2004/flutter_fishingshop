class TypeOfReel{
  int id;
  String type;

  TypeOfReel({
    required this.id,
    required this.type
  });

  factory TypeOfReel.fromMap(Map typeOfReelMap){
    return TypeOfReel(
      id: typeOfReelMap['id'],
      type: typeOfReelMap['type']
      );
  }
  Map<String, dynamic> toMap(TypeOfReel typeOfReel) {
    return {
      'id': typeOfReel.id,
      'type': typeOfReel.type,
    };
  }
}