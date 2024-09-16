import 'package:fishingshop/screen/main_screen.dart';
import 'package:fishingshop/screen/reel/reel_create_screen.dart';
import 'package:fishingshop/screen/reel/reel_details.dart';
import 'package:fishingshop/screen/reel/reel_edit_screen.dart';
import 'package:fishingshop/screen/reel/reel_screen.dart';
import 'package:fishingshop/screen/rod/rod_create_screen.dart';
import 'package:fishingshop/screen/rod/rod_details.dart';
import 'package:fishingshop/screen/rod/rod_edit_screen.dart';
import 'package:fishingshop/screen/rod/rods_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/rods': (context) => const RodsScreen(),
        '/rodsDetails': (context) => const RodDetails(),
         '/addRod': (context) => const RodCreateScreen(),
         '/editRod': (context) => const RodEditScreen(),
         '/reels': (context) => const ReelsScreen(),
         '/reelsDetails': (context) => const ReelDetails(),
         '/addReel': (context) => const ReelCreateScreen(),
         '/editReel': (context) => const ReelEditScreen(),
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
  
