import 'package:flutter/material.dart';
import 'package:kibumess/GrocerryApp/dashboard.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/splash.png",
              height: 300,
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                "Buy Fresh Groceries",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00A368)),
              ),
            ),
            const SizedBox(height: 50,),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
              },
              child: Ink(
                padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 16),
                decoration: BoxDecoration(
                    color: const Color(0xFF00A368),
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: const Text("Get Started",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
