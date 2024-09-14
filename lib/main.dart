import 'package:fishingshop/screen/main_screen.dart';
import 'package:fishingshop/screen/rod_create_screen.dart';
import 'package:fishingshop/screen/rod_details.dart';
import 'package:fishingshop/screen/rods_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/home': (context) => const RodsScreen(),
        '/details': (context) => const RodDetails(),
         '/addRod': (context) => const RodCreateScreen(),
      },
    );
  }
}
    /*return  MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const MainScreen(),
          '/home': (context) => const HomeScreen(),
        },
      );*/
  
