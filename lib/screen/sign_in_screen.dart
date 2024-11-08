import 'dart:convert';
import 'package:fishingshop/DTOs/auth_request.dart';
import 'package:fishingshop/service/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();
  String emailStr = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser(AuthRequest authRequest) async {
    var url = Uri.parse(baseURL + '/auth/authenticate');
    try {
      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(authRequest.toMap(authRequest)),
      );

      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['username'] != null) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        prefs.setString('role', jsonResponse['role']);
        prefs.setString('username', jsonResponse['username']);
        Navigator.pushNamed(context, '/main');
      } else {
        // Обработка ошибок
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Неверные учетные данные')),
        );
      }
    } catch (e) {
      // Обработка ошибок сети
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
            'Авторизация',
            style: TextStyle(color: Colors.black),
          ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset("lib/images/fishLogin.jpg", width: 250, height: 250),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'CATFISH',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Электронная почта'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите электронную почту';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    emailStr = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Пароль'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите пароль';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          AuthRequest authRequest =
                              AuthRequest(email: emailStr, password: password);
                          loginUser(authRequest);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Войти',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register'); // Убедитесь, что маршрут '/register' определен
                      },
                      child: const Text(
                        'Регистрация',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}