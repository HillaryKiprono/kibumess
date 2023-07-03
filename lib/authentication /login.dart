import 'package:flutter/material.dart';
import 'package:kibumess/authentication%20/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/userDashboard.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    // Pass context for navigation
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Retrieve the user credentials from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedUsername = prefs.getString('username') ?? '';
    String storedPassword = prefs.getString('password') ?? '';

    if (username == storedUsername && password == storedPassword) {
      // Login successful, navigate to UserDashboard
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDashboard(username: username),
        ),
      );
    } else {
      // Login failed
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/res1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Username',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(20.0),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(20.0),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _login(context);
                      },
                      child: Text('Login'),
                    ),
                  ),
                  Padding(padding:const EdgeInsets.only(left: 00),child: TextButton(onPressed: (){

                  }, child: const Text("Forgot Password?",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)))
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));}, child: Text("Click here",style: TextStyle(color: Colors.blue),))
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
