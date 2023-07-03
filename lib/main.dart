import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kibumess/GrocerryApp/dashboard.dart';
import 'package:kibumess/GrocerryApp/splashscreen.dart';
import 'package:kibumess/authentication%20/login.dart';
import 'package:kibumess/mpesa/MpesaStkPushService.dart';
import 'package:shimmer/main.dart';

void main(){
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

      home: STKPushScreen(),
    );

  }
}
