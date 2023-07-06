import 'package:flutter/material.dart';
import 'package:kibumess/admin/addFood.dart';
import 'package:kibumess/authentication%20/login.dart';

class AdminDashboard extends StatefulWidget {
   AdminDashboard({super.key, required this.username,});
final String username;
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AdminDashboard"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.red),
              accountName: Text("Hello ${widget.username} Welcome"),
              accountEmail: Text(""),
              currentAccountPicture: const CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFood()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.add_box_rounded,
                  color: Colors.red,
                ),
                title: Text("Add Food"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginActivity()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: Text("Logout"),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
