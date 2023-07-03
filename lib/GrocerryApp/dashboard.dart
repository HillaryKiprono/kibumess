import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:kibumess/GrocerryApp/widgets/CategoryWidget.dart';
import 'package:kibumess/GrocerryApp/widgets/ItemsWidget.dart';
import 'package:kibumess/GrocerryApp/widgets/PopularItemsWidget.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00A368),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            //custom appBar
            Container(
              margin: const EdgeInsets.only(left: 15, right: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Color(0xFF00A368),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 0.2)
                        ]),
                    child: badges.Badge(
                      badgeContent: const Text(
                        "3",
                        style: TextStyle(color: Colors.white),
                      ),
                      badgeStyle: const badges.BadgeStyle(
                          badgeColor: Colors.red, padding: EdgeInsets.all(6.0)),
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //Welcome Message
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "What do you  want to Buy?",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),

            //Search Widget
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchBar(
                leading: Icon(Icons.search),
                hintText: "Search here...",
              ),
            ),

            //Products Widget

            Container(
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryWidget(),
                  PopularItemWidget(),
                  ItemsWidget()
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
