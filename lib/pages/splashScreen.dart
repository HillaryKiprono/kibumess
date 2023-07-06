import 'package:flutter/material.dart';
import 'package:kibumess/authentication%20/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 200),
        child: const Text(
          "license kibabii university",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 240,
              child: Image.asset("assets/images/splash.png"),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Place your Food order now",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text("Get Started"),
            )
          ],
        ),
      ),
    );
  }
}
