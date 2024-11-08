import 'package:fishingshop/screen/cart/cart_screen.dart';
import 'package:fishingshop/screen/main_screen.dart';
import 'package:fishingshop/screen/manufacturers/manufacturers_screen.dart';
import 'package:fishingshop/screen/reel/reel_create_screen.dart';
import 'package:fishingshop/screen/reel/reel_details.dart';
import 'package:fishingshop/screen/reel/reel_edit_screen.dart';
import 'package:fishingshop/screen/reel/reel_screen.dart';
import 'package:fishingshop/screen/register_screen.dart';
import 'package:fishingshop/screen/rod/rod_create_screen.dart';
import 'package:fishingshop/screen/rod/rod_details.dart';
import 'package:fishingshop/screen/rod/rod_edit_screen.dart';
import 'package:fishingshop/screen/rod/rods_screen.dart';
import 'package:fishingshop/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(token: prefs.getString('token'),));
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({
    @required this.token,
    Key? key,
}): super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/main',
      //home: (token != null )? const MainScreen():const SignInPage(),
    
      routes: {
        '/main': (context) =>  const MainScreen(),
        '/auth': (context) =>  const SignInPage(),
        '/rods': (context) => const RodsScreen(),
        '/rodsDetails': (context) => const RodDetails(),
         '/addRod': (context) => const RodCreateScreen(),
         '/editRod': (context) => const RodEditScreen(),
         '/reels': (context) => const ReelsScreen(),
         '/reelsDetails': (context) => const ReelDetails(),
         '/addReel': (context) => const ReelCreateScreen(),
         '/editReel': (context) => const ReelEditScreen(),
         '/carts':(context) => const CartScreen(),
         '/register':(context) => const RegisterPage(),
         '/manufacturers':(context) => const ManufacturersScreen(),
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
  
