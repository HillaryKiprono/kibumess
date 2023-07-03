import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../model/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> cartItems = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }
  Future<void> fetchCartItems() async {
    DatabaseReference cartRef = FirebaseDatabase.instance.reference().child('cart');

    try {
      DatabaseEvent event = await cartRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          // Create CartItem object from the retrieved data
          CartItem cartItem = CartItem.fromJson(value);

          // Add the cartItem to the list
          setState(() {
            cartItems.add(cartItem);
          });
        });
      }
    } catch (error) {
      // Handle the error
      print('Error fetching cart items: $error');
    }
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
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return CartItemWidget(
            image: cartItems[index].image,
            name: cartItems[index].name,
            price: cartItems[index].price,
            quantity: cartItems[index].quantity,
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.red,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total Amount: Ksh1500",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ElevatedButton(onPressed: (){}, child: Text("CheckOut"))

          ],
        ),
      ),

    );
  }
}

class CartItemWidget extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  final int quantity;

  CartItemWidget({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        image,
        width: 100,
      ),
      title: Text(name),
      subtitle: Text('Price: Ksh $price'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              if (quantity > 1) {
                // Decrease quantity
                //quantity--;
              }
            },
            icon: Icon(Icons.remove_circle),
          ),
          Text("$quantity"),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_circle),
          ),
        ],
      ),
    );
  }
}
