import 'package:fishingshop/screen/main_screen.dart';
import 'package:fishingshop/screen/order/order_history_screen.dart';
import 'package:fishingshop/screen/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';

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
        centerTitle: true,
        backgroundColor: const Color(0xffffffff),
      ),
      body: Container(
        color: const Color(0x1200CCFF),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 46,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      username != null ? username![0] : 'U', // Первая буква имени или 'U' если имя отсутствует
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Отступ между аватаром и текстом
                  if (role != null)
                    Text(
                      'Логин: $username',
                      style: const TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (role == "USER")
              _buildElevatedButton(
                context,
                title: 'Заказы',
                icon: Icons.shopping_cart,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderScreen()),
                  );
                },
              ),
            const SizedBox(height: 10),
            _buildElevatedButton(
              context,
              title: 'История заказов',
              icon: Icons.history,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderHistoryScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            if (role != null)
              _buildElevatedButton(
                context,
                title: 'Изменение пароля',
                icon: Icons.lock,
                onPressed: () {
                  Navigator.pushNamed(context, '/changePass');
                },
              ),
            const SizedBox(height: 10),
            if (role != null)
              _buildElevatedButton(
                context,
                title: 'Выйти',
                icon: Icons.exit_to_app,
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
              ),
          ],
        ),
      ),
    );
  }

  // Метод для создания стилизованной кнопки
  Widget _buildElevatedButton(BuildContext context, {required String title, required IconData icon, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}