// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import '../model/cart_item.dart';
//
// class CartScreen extends StatefulWidget {
//   CartScreen({Key? key, required this.username}) : super(key: key);
//
//   final String username;
//
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   List<CartItem> cartItems = []; // Initialize with an empty list
//   double totalItemAmount = 0.0;
//   double totalPrice = 0.0;
//   late String fetchedUsername;
//
//   void calculateAmount() {}
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCartItems();
//     calculateAmount();
//   }
//
//   Future<void> fetchCartItems() async {
//     DatabaseReference cartRef = FirebaseDatabase.instance.ref().child('cart');
//
//     try {
//       DatabaseEvent event = await cartRef.once();
//       DataSnapshot snapshot = event.snapshot;
//       if (snapshot.value != null) {
//         Map<dynamic, dynamic> values =
//         snapshot.value as Map<dynamic, dynamic>;
//         values.forEach((key, value) {
//           // Create CartItem object from the retrieved data
//           CartItem cartItem = CartItem.fromJson(value);
//
//           // Add the cartItem to the list whose username merges that of the one who logins
//           if (cartItem.username == widget.username) {
//             setState(() {
//               cartItems.add(cartItem);
//             });
//           }
//         });
//       }
//     } catch (error) {
//       // Handle the error
//       print('Error fetching cart items: $error');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (cartItems.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Cart'),
//         ),
//         body: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     void calculateAmount() {
//       //totalItemAmount=cartItems[] price*cartItem.quantity;
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${widget.username} Cart Items"),
//       ),
//       body: ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           return CartItemWidget(
//             image: cartItems[index].image,
//             name: cartItems[index].name,
//             price: cartItems[index].price,
//             quantity: cartItems[index].quantity,
//             cartItemId: '',
//             onRemoveItem: () {
//               setState(() {
//                 cartItems.removeAt(index);
//               });
//             },
//           );
//         },
//       ),
//       bottomNavigationBar: Container(
//         color: Colors.red,
//         height: 50,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Total Amount: $totalItemAmount",
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {},
//               child: const Text("CheckOut"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CartItemWidget extends StatefulWidget {
//   final String image;
//   final String name;
//   final double price;
//   final int quantity;
//   final String cartItemId;
//   final VoidCallback onRemoveItem;
//
//   CartItemWidget({
//     Key? key,
//     required this.image,
//     required this.name,
//     required this.price,
//     required this.quantity,
//     required this.cartItemId,
//     required this.onRemoveItem,
//   }) : super(key: key);
//
//   @override
//   _CartItemWidgetState createState() => _CartItemWidgetState();
// }
//
// class _CartItemWidgetState extends State<CartItemWidget> {
//   int _quantity = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _quantity = widget.quantity;
//   }
//
//   void _incrementQuantity() {
//     setState(() {
//       _quantity++;
//     });
//   }
//
//   void _decrementQuantity() {
//     if (_quantity > 1) {
//       setState(() {
//         _quantity--;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Image.network(
//         widget.image,
//         width: 100,
//       ),
//       title: Text(widget.name),
//       subtitle: Text('Price: Ksh ${widget.price}'),
//       trailing: Expanded(
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               onPressed: _decrementQuantity,
//               icon: const Icon(Icons.remove_circle, color: Colors.red),
//             ),
//             Text("$_quantity"),
//             IconButton(
//               onPressed: _incrementQuantity,
//               icon: const Icon(Icons.add_circle, color: Colors.red),
//             ),
//             IconButton(
//               onPressed: widget.onRemoveItem,
//               icon: const Icon(Icons.delete, color: Colors.red),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../model/cart_item.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = []; // Initialize with an empty list
  double totalItemAmount = 0.0;
  double totalPrice = 0.0;
  late String fetchedUsername;


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
        Map<dynamic, dynamic> values =
        snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          // Create CartItem object from the retrieved data
          CartItem cartItem = CartItem.fromJson(value);

          // Add the cartItem to the list whose username merges that of the one who logins
          if (cartItem.username == widget.username) {
            setState(() {
              cartItems.add(cartItem);
            });
          }
        });
      }
    } catch (error) {
      // Handle the error
      print('Error fetching cart items: $error');
    }
  }
  void calculateAmount() {
    double total = 0.0;
    for (var item in cartItems) {
      double itemAmount = item.price * item.quantity;
      total += itemAmount;
    }
    setState(() {
      totalItemAmount = total;
      print("total amount to be paid =${totalItemAmount}");

    });
    print("total amount to be paid =${totalItemAmount}");
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
            image: cartItems[index].image,
            name: cartItems[index].name,
            price: cartItems[index].price,
            quantity: cartItems[index].quantity,
            onRemoveItem: () {
              setState(() {
                cartItems.removeAt(index);
              });
              _removeItemFromCart(index);
            },
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
              onPressed: () {},
              child: const Text("CheckOut"),
            ),
          ],
        ),
      ),
    );
  }



  // void _removeItemFromCart(int index) {
  //   DatabaseReference cartRef = FirebaseDatabase.instance.ref().child('cart');
  //   CartItem itemToRemove = cartItems[index];
  //
  //   cartRef
  //       .orderByChild('username')
  //       .equalTo(itemToRemove.username)
  //       .once()
  //       .then((DatabaseEvent event) {
  //     DataSnapshot snapshot = event.snapshot;
  //     Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
  //     values.forEach((key, value) {
  //       if (value['image'] == itemToRemove.image &&
  //           value['name'] == itemToRemove.name &&
  //           value['price'] == itemToRemove.price &&
  //           value['quantity'] == itemToRemove.quantity
  //           // &&
  //           // value['username'] == itemToRemove.username
  //       )
  //       {
  //         cartRef.child(key).remove();
  //       }
  //     });
  //   })
  //       .catchError((error) {
  //     print('Error removing item from cart: $error');
  //   });
  // }
  void _removeItemFromCart(int index) {
    DatabaseReference cartRef = FirebaseDatabase.instance.ref().child('cart');
    CartItem itemToRemove = cartItems[index];

    cartRef
        .orderByChild('name')
        .equalTo(itemToRemove.name)
        .once()
        .then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        if (value['image'] == itemToRemove.image &&
            value['price'] == itemToRemove.price &&
            value['quantity'] == itemToRemove.quantity &&
            value['username'] == itemToRemove.username) {
          cartRef.child(key).remove();
        }
      });
    })
        .catchError((error) {
      print('Error removing item from cart: $error');
    });
  }



 }

class CartItemWidget extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  final int quantity;
  final VoidCallback onRemoveItem;

  CartItemWidget({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.onRemoveItem,
  }) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        widget.image,
        width: 100,
      ),
      title: Text(widget.name),
      subtitle: Text('Price: Ksh ${widget.price}'),
      trailing: Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: _decrementQuantity,
              icon: const Icon(Icons.remove_circle, color: Colors.red),
            ),
            Text("$_quantity"),
            IconButton(
              onPressed: _incrementQuantity,
              icon: const Icon(Icons.add_circle, color: Colors.red),
            ),
            IconButton(
              onPressed: widget.onRemoveItem,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
