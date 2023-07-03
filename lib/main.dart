import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kibumess/GrocerryApp/dashboard.dart';
import 'package:kibumess/GrocerryApp/splashscreen.dart';
import 'package:kibumess/authentication%20/login.dart';
import 'package:kibumess/mpesa/MpesaStkPushService.dart';
import 'package:kibumess/pages/cart_screen.dart';
import 'package:shimmer/main.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'dart:async';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MpesaFlutterPlugin.setConsumerKey("CECxq2amDDKMWYLEKrQVdZIAq7uLd0AM");
  MpesaFlutterPlugin.setConsumerSecret("2A9ao8PF6kaeZiA4");
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title:" Kibu Mess",
      debugShowCheckedModeBanner: false,
      // routes: {
      //   "/": (context)=>const SplashScreen(),
      //   "Dashboard": (context)=>Dashboard()
      // },

      home: LoginPage(),
    );

  }
}
