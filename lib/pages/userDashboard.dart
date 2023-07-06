import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kibumess/pages/cart_screen.dart';
import 'package:kibumess/pages/fetch_orders.dart';
import 'package:shimmer/shimmer.dart';

import '../model/food_item.dart';
import 'food_details.dart';

class UserDashboard extends StatefulWidget {
  final String username;

  const UserDashboard({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  Future<List<FoodItem>>? _foodItemsFuture;

  @override
  void initState() {
    super.initState();
    _fetchFoodItems();
  }

  Future<void> _fetchFoodItems() async {
    final FirebaseDataManager manager = FirebaseDataManager();
    final List<FoodItem> foodItems = await manager.fetchFoodItems();
    setState(() {
      _foodItemsFuture = Future.value(foodItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.red,
          title: Text(
            "Kibu Mess",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartScreen(
                                username: widget.username,
                              )));
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                )),
          ],
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
              const InkWell(
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.red,
                  ),
                  title: Text("Home"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FetchActivities()));
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.shopping_basket,
                    color: Colors.red,
                  ),
                  title: Text("My Orders"),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.red,
                  ),
                  title: Text("Settings"),
                ),
              ),
              InkWell(
                onTap: () {},
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
        body: FutureBuilder<List<FoodItem>>(
          future: _foodItemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Use shimmer layout while waiting for data
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6, // Show 6 shimmer items (you can adjust as needed)
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Card(
                      child: Container(
                        color: Colors
                            .white, // Use the same color as the footer container
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child:
                    Text("Error: ${snapshot.error}"), // Display error message
              );
            } else if (snapshot.hasData) {
              final List<FoodItem> foodItems = snapshot.data!;
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  final foodItem = foodItems[index];

                  return Card(
                    child: Hero(
                      tag: const Text("hero"),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FoodDetails(
                                      foodImage_details: foodItem.imageUrl,
                                      foodName_details: foodItem.name,
                                      foodPrice_details: foodItem.price,
                                      username: widget.username,
                                    ))),
                        child: GridTile(
                            footer: Container(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    foodItem.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("Ksh.${foodItem.price}"),
                                ],
                              ),
                            ),
                            child: Image.network(foodItem.imageUrl)),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("No data available."), // Display no data message
              );
            }
          },
        ));
  }
}

class SingleFood extends StatelessWidget {
  final String foodImage;
  final String foodName;
  final String foodPrice;
  final String username;

  SingleFood(
      {required this.foodName,
      required this.foodPrice,
      required this.foodImage,
      required this.username});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: Text("hero9"),
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FoodDetails(
                      foodImage_details: foodImage,
                      foodName_details: foodName,
                      foodPrice_details: foodPrice,
                      username: username))),
          child: GridTile(
            footer: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    foodName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Ksh.$foodPrice"),
                ],
              ),
            ),
            child: Image.asset(foodImage),
          ),
        ),
      ),
    );
  }
}

class FirebaseDataManager {
  final DatabaseReference _database;

  FirebaseDataManager() : _database = FirebaseDatabase.instance.reference();

  Future<List<FoodItem>> fetchFoodItems() async {
    final Completer<List<FoodItem>> completer = Completer<List<FoodItem>>();
    final List<FoodItem> foodItems = [];

    _database.child("foods").onValue.listen((event) {
      final DataSnapshot snapshot = event.snapshot;
      final Map<dynamic, dynamic>? foodData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (foodData != null) {
        foodData.forEach((key, value) {
          final Map<dynamic, dynamic> foodItemData =
              value as Map<dynamic, dynamic>;
          final FoodItem foodItem = FoodItem(
            name: foodItemData["name"],
            description: foodItemData["description"],
            price: foodItemData["price"],
            imageUrl: foodItemData["image_url"],
          );
          foodItems.add(foodItem);
        });
      }
      completer.complete(foodItems);
    });

    return completer.future;
  }
}
