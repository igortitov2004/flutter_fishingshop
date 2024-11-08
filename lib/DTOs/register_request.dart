class RegisterRequest{
  String email;
  String password;
  String firstname;
  String surname;
  String patronymic;


  RegisterRequest({
    required this.email,
    required this.password,
    required this.firstname,
    required this.surname,
    required this.patronymic
  });

    Map<String, dynamic> toMap(RegisterRequest request) {
    return {
      "email": request.email,
      "firstname": request.firstname,
      "surname": request.surname,
      "patronymic": request.patronymic,
      "password": request.password,
    };
  }
}