import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kibumess/pages/cart_screen.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:badges/badges.dart' as badges;

import '../model/cartModel.dart';

class FoodDetails extends StatefulWidget {
  final foodImage_details;
  final foodName_details;
  final foodPrice_details;
  final foodqty;
  final String username; // Add the username parameter


  FoodDetails({
    super.key,
    required this.foodImage_details,
    required this.foodName_details,
    required this.foodPrice_details,
    this.foodqty,
    required  this.username,
  });

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  List<CartItemData> cartItems = [];
  int simpleIntInput = 0;
  int _cartBadgeAmount = 0;
  late bool _showCartBadge;
  Color color = Colors.red;

  Widget _shoppingCartBadge() {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -4, end: 0),
      badgeAnimation: badges.BadgeAnimation.slide(),
      showBadge: _showCartBadge,
      badgeStyle: badges.BadgeStyle(
        badgeColor: color,
      ),
      badgeContent: Text(
        _cartBadgeAmount.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
    );
  }

  void addToCart(CartItemData cartItem) {
    setState(() {
      cartItems.add(cartItem);
      _cartBadgeAmount++;
      _showCartBadge = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _showCartBadge = _cartBadgeAmount > 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Details"),
        actions: [
          _shoppingCartBadge(),
        ],
      ),
      body: Container(
        height: 400,
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                widget.foodImage_details,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Name: ${widget.foodName_details}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Price:Ksh. ${widget.foodPrice_details}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            QuantityInput(
              value: simpleIntInput,
              onChanged: (value) {
                setState(() {
                  simpleIntInput = int.parse(value.replaceAll(',', ''));
                });
              },
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Create a CartItemData object
                CartItemData cartItem = CartItemData(
                  image: widget.foodImage_details,
                  name: widget.foodName_details,
                  price: double.parse(widget.foodPrice_details),
                  quantity: simpleIntInput,
                  username: widget.username,
                );

                // Add the cartItem to the Firebase Realtime Database
                DatabaseReference cartRef = FirebaseDatabase.instance
                    .reference()
                    .child('cart');

                cartRef.push().set(cartItem.toJson());

                // Pass the CartItemData object to the addToCart callback function
                addToCart(cartItem);

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CartScreen(cartItems: cartItems),
                //   ),
                // );
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add to Cart'),
            ),

          ],
          
        ),
        
      ),

    );
  }
}
