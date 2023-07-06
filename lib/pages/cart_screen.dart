
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kibumess/mpesa/MpesaStkPushService.dart';
import '../model/cart_item.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key, required this.username}) : super(key: key);

  final String username;


  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [];
  double totalItemAmount = 0.0;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    DatabaseReference cartRef = FirebaseDatabase.instance.ref().child('cart');

    try {
      DatabaseEvent event = await cartRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          CartItem cartItem = CartItem.fromJson(value);
          if (cartItem.username == widget.username) {
            setState(() {
              cartItems.add(cartItem);
            });
          }
        });
        calculateAmount();
      }
    } catch (error) {
      print('Error fetching cart items: $error');
    }
  }

  void calculateAmount() {
    double total = 0.0;
    for (var item in cartItems) {
      double itemAmount = item.quantity * item.price;
      total += itemAmount;
    }
    setState(() {
      totalItemAmount = total;
    });
  }

  void incrementQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
      calculateAmount();
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        calculateAmount();
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
      calculateAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.username} Cart Items"),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return CartItemWidget(
            cartItem: cartItems[index],
            onIncrement: () => incrementQuantity(index),
            onDecrement: () => decrementQuantity(index),
            onRemove: () => removeItem(index),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.red,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Amount: $totalItemAmount",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform checkout or payment logic here
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MpesaStkPush(
                  totalAmount: totalItemAmount,
                    cartItems: cartItems,
                  username: widget.username,
                )));
              },
              child: const Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(cartItem.image),
      title: Text(cartItem.name),
      subtitle: Text('Price: ${cartItem.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrement,
            icon: const Icon(Icons.remove_circle,color: Colors.blue,),
          ),
          Text(cartItem.quantity.toString()),
          IconButton(
            onPressed: onIncrement,
            icon: const Icon(Icons.add_circle,color: Colors.blue,),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.delete,color: Colors.red,),
          ),
        ],
      ),
    );
  }
}
