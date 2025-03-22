import 'dart:convert';
import 'package:fishingshop/DTOs/auth_request.dart';
import 'package:fishingshop/DTOs/register_request.dart';
import 'package:fishingshop/service/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();
  String emailStr = '';
  String password = '';
  String firstname = '';
  String surname = '';
  String patronymic = '';

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void registerUser(RegisterRequest registerRequest) async {
    var url = Uri.parse(baseURL + '/auth/register');
    try {
      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(registerRequest.toMap(registerRequest)),
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
          SnackBar(content: Text('Не удалось зарегистрироваться')),
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
        
       
        
        title: Text(
              'Регистрация',
              style: TextStyle(color: Colors.black),
            ),
         centerTitle: true,
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
                  decoration: InputDecoration(labelText: 'Имя'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите имя';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    firstname = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Фамилия'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите фамилию';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    surname = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Отчество'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите отчество';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    patronymic = value!;
                  },
                ),
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      RegisterRequest registerRequest = RegisterRequest(
                        email: emailStr,
                        password: password,
                        firstname: firstname,
                        surname: surname,
                        patronymic: patronymic,
                      );
                      registerUser(registerRequest);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Зарегистрироваться',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}