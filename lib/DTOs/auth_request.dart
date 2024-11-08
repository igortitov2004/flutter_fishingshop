class AuthRequest{
  String email;
  String password;


  AuthRequest({
    required this.email,
    required this.password,
  });

    Map<String, dynamic> toMap(AuthRequest request) {
    return {
      "email": request.email,
      "password": request.password,
    };
  }
}