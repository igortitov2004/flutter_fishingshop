import 'package:flutter/material.dart';
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
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text('CATFISH'),
        backgroundColor: const Color(0xffffffff),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.account_circle),
            color: const Color(0xffffffff),
            itemBuilder: (context) => [
              if (role != null)
                PopupMenuItem(
                  child: Text(
                    'Логин: ${username}',
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
              if (role == "USER")
                PopupMenuItem(
                  child: ListTile(
                    title: const Text('Заказы'),
                    onTap: () {
                      Navigator.pushNamed(context, '/orders');
                      // Не закрываем меню
                    },
                  ),
                ),
              if (role != null)
                PopupMenuItem(
                  child: ListTile(
                    title: const Text('Изменение пароля'),
                    onTap: () {
                      Navigator.pushNamed(context, '/changePass');
                      // Не закрываем меню
                    },
                  ),
                ),
              if (role != null)
                PopupMenuItem(
                  child: ListTile(
                    title: const Text('Выйти'),
                    onTap: () {
                      prefs.remove('token');
                      prefs.remove('role');
                      prefs.remove('username');
                      Navigator.pushNamed(context, '/main');
                    },
                  ),
                ),
              if (role == null)
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Авторизация',
                    style: const TextStyle(color: Colors.blue)),
                    onTap: () {
                      //_logout();
                      Navigator.pushNamed(context, '/auth');
                    },
                  ),
                ),
                 if (role == null)
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Регистрация',
                    style: const TextStyle(color: Colors.blue)),
                    onTap: () {
                      //_logout();
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: const Color(0x1200CCFF),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/rods');
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
                    const Icon(Icons.list, color: Colors.blue),
                    const SizedBox(width: 8),
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
                  Navigator.pushNamed(context, '/reels');
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
                    const Icon(Icons.list, color: Colors.blue),
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
               if (role =='ADMIN')
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/manufacturers');
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
                    const Icon(Icons.list, color: Colors.blue),
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
                 if (role =='ADMIN')
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
                    const Icon(Icons.list, color: Colors.blue),
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
    );
  }
}
