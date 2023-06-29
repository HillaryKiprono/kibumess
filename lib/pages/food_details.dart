import 'package:flutter/material.dart';
import 'package:kibumess/pages/cart_screen.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:badges/badges.dart' as badges;

import '../model/cartModel.dart';

class FoodDetails extends StatefulWidget {
  List<String> cartItems = []; //a list to store the items in the cart

  final foodImage_details;
  final foodName_details;
  final foodPrice_details;
  final foodqty;

  FoodDetails({
    super.key,
    required this.foodImage_details,
    required this.foodName_details,
    required this.foodPrice_details,
    this.foodqty,
  });

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  List<CartItem> cartItems = []; // List to store the items in the cart

  void addToCart(CartItem cartItem) {
    setState(() {
      cartItems.add(cartItem); // Add the item to the cartItems list
    });
  }

  int simpleIntInput = 0;
  int _cartBadgeAmount = 0;
  late bool _showCartBadge;
  Color color = Colors.red;
  bool _isAddedToCart = false; // Track if the item is added to cart

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
                  )
                ],
              ),
            ),
            QuantityInput(
                value: simpleIntInput,
                onChanged: (value) {
                  setState(() {
                    simpleIntInput = int.parse(value.replaceAll(',', ''));
                  });
                }),
            // ElevatedButton.icon(
            //   onPressed: () {
            //     if (!_isAddedToCart) {
            //       setState(() {
            //         _cartBadgeAmount++; // Increment the badge number
            //         _isAddedToCart = true; // Set item added to cart flag
            //       });
            //     }
            //   },
            //   icon: const Icon(Icons.shopping_cart),
            //   label: Text(_isAddedToCart ? 'Item Added' : 'Add To Cart'),
            // ),

            ElevatedButton.icon(
              onPressed: () {
                if (_cartBadgeAmount >= 0 && _cartBadgeAmount < 1) {
                  setState(() {
                    _cartBadgeAmount++;
                  });

                  // Create a CartItem object
                  CartItem cartItem = CartItem(
                    image: widget.foodImage_details,
                    name: widget.foodName_details,
                    price: double.parse(widget.foodPrice_details),
                    quantity: simpleIntInput,
                  );

                  // Pass the CartItem object to the addToCart callback function
                  addToCart(cartItem);

                  // Navigate to the CartScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cartItems: cartItems),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text("Add To Cart"),
            )
          ],
        ),
      ),
    );
  }
}

Widget _shoppingCartBadge() {
  var _showCartBadge;
  var _cartBadgeAmount;
  Color color = Colors.red;
  return badges.Badge(
    position: badges.BadgePosition.topEnd(top: 0, end: 3),
    badgeAnimation: const badges.BadgeAnimation.slide(
        // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
        // curve: Curves.easeInCubic,
        ),
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

PreferredSizeWidget _tabBar() {
  return TabBar(tabs: [
    Tab(
      icon: badges.Badge(
        badgeStyle: const badges.BadgeStyle(
          badgeColor: Colors.blue,
        ),
        position: badges.BadgePosition.topEnd(top: -14),
        badgeContent: const Text(
          '3',
          style: TextStyle(color: Colors.white),
        ),
        child: Icon(
          Icons.account_balance_wallet,
          color: Colors.grey[800],
        ),
      ),
    ),
    Tab(
      child: badges.Badge(
        badgeStyle: badges.BadgeStyle(
          shape: badges.BadgeShape.square,
          borderRadius: BorderRadius.circular(5),
          padding: EdgeInsets.all(2),
          badgeGradient: const badges.BadgeGradient.linear(
            colors: [
              Colors.purple,
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        position: badges.BadgePosition.topEnd(top: -12, end: -20),
      ),
    ),
  ]);
}
