import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kibumess/admin/addFood.dart';
import 'package:kibumess/authentication%20/login.dart';
import 'package:kibumess/authentication%20/register.dart';
import 'package:kibumess/displayFood.dart';
import 'package:kibumess/pages/cart_screen.dart';
import 'package:kibumess/pages/fetchFood.dart';

import 'model/cartModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kibu Mess Meal',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        home:  RegisterActivity(),
      //home: CartScreen(),
    );
  }
}


