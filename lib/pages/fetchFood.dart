import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FoodItem {
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  FoodItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class FirebaseDataManager {
  final DatabaseReference _database;

  FirebaseDataManager() : _database = FirebaseDatabase.instance.reference();

  Future<List<FoodItem>> fetchFoodItems() async {
    final Completer<List<FoodItem>> completer = Completer<List<FoodItem>>();
    final List<FoodItem> foodItems = [];

    _database.child("foods").onValue.listen((event) {
      final DataSnapshot snapshot = event.snapshot;
      final Map<dynamic, dynamic>? foodData = snapshot.value as Map<dynamic, dynamic>?;

      if (foodData != null) {
        foodData.forEach((key, value) {
          final Map<dynamic, dynamic> foodItemData = value as Map<dynamic, dynamic>;
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

class FoodGridView extends StatefulWidget {
  @override
  _FoodGridViewState createState() => _FoodGridViewState();
}

class _FoodGridViewState extends State<FoodGridView> {
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
    return
      FutureBuilder<List<FoodItem>>(
      future: _foodItemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(), // Display circular progress bar
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"), // Display error message
          );
        } else if (snapshot.hasData) {
          final List<FoodItem> foodItems = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              final foodItem = foodItems[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(
                        foodItem.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(foodItem.name),
                          Text(foodItem.description),
                          Text(foodItem.price),
                        ],
                      ),
                    ),
                  ],
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
    );
  }
}
