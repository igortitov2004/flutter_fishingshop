import 'package:fishingshop/screen/manufacturers/manufacturers_screen.dart';
import 'package:fishingshop/screen/order/order_screen.dart';
import 'package:fishingshop/screen/reel/reel_screen.dart';
import 'package:fishingshop/screen/register_screen.dart';
import 'package:fishingshop/screen/rod/rods_screen.dart';
import 'package:fishingshop/screen/sign_in_screen.dart';
import 'package:fishingshop/screen/slider.dart';
import 'package:fishingshop/screen/user/personal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? token;
  String? role;
  String? username;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
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
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              if (role != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonalScreen()),
                );
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInPage()),
                );
              }
            },
          ),
        ],
      ),

      // backgroundColor: Color.fromARGB(255, 0, 204, 255),
      body: Container(
        height: double.infinity,
        color: const Color(0x1200CCFF),
        child: SingleChildScrollView(
          // color: const Color(0x1200CCFF),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SimpleSlider(), // Убираем Expanded, чтобы кнопки шли сразу под слайдером
                const SizedBox(height: 20), // Отступ между слайдером и кнопками
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RodsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "lib/images/rodSVG.svg",
                        width: 24,
                        height: 24,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Удилища',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReelsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "lib/images/reelSVG.svg",
                        width: 24,
                        height: 24,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Катушки',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (role == 'ADMIN')
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ManufacturersScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.business, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text(
                          'Производители',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (role == 'ADMIN')
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/types');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.category, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text(
                          'Типы катушек и удилищ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (role == 'USER')
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/carts');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.shopping_cart, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text(
                          'Корзина',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
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
