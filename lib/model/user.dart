class User{
  int id;
  String email;
  String surname;
  String firstName;
  String patronymic;

  User({
    required this.id,
    required this.email,
    required this.surname,
    required this.firstName,
    required this.patronymic
  });

    factory User.fromMap(Map userMap){
    return User(
      id: userMap['id'],
      email: userMap['email'],
      surname: userMap['surname'],
      firstName: userMap['firstName'],
      patronymic: userMap['patronymic'],
      );
  }
}