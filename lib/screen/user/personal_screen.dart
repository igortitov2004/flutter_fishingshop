import 'package:fishingshop/screen/main_screen.dart';
import 'package:fishingshop/screen/order/order_history_screen.dart';
import 'package:fishingshop/screen/order/order_screen.dart';
import 'package:fishingshop/screen/register_screen.dart';
import 'package:fishingshop/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  String? role;
  String? username;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
      username = prefs.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Image.asset(
              "lib/images/fishLogin.jpg",
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 8),
            const Text(
              'CATFISH',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        backgroundColor: const Color(0xffffffff),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (role != null)
              Text(
                'Логин: $username',
                style: const TextStyle(color: Colors.green, fontSize: 18),
              ),
            const SizedBox(height: 20),
            if (role == "USER")
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderScreen()),
                  );
                },
                child: const Text('Заказы'),
              ),
               ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderHistoryScreen()),
                  );
                },
                child: const Text('История заказов'),
              ),
            const SizedBox(height: 10),
            if (role != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/changePass');
                },
                child: const Text('Изменение пароля'),
              ),
            const SizedBox(height: 10),
            if (role != null)
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('token');
                  prefs.remove('role');
                  prefs.remove('username');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
                child: const Text('Выйти'),
              ),
            
          ],
        ),
      ),
    );
  }
}