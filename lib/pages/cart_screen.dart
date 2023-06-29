// import 'package:flutter/material.dart';
//
// import '../model/cartModel.dart';
// import '../singleItem/cartItemWidget.dart';
//
// class CartScreen extends StatelessWidget {
//   final List<CartItem> cartItems;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           return CartItemWidget(image: '',
//
//           );
//         },
//       ),
//     );
//   }
// }
//
// class CartItemWidget extends StatelessWidget {
//   // final CartItem cartItem;
//   final String image;
//   final String name;
//   final double price;
//   final int quantity;
//
//   CartItemWidget(
//       {required this.image,
//       required this.name,
//       required this.price,
//       required this.quantity});
//
//   // const CartItemWidget({super.key, required this.cartItem});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Image.network(
//         image,
//         width: 100,
//       ),
//       title: Text(name),
//       subtitle: Text('Price: ksh${price}'),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             onPressed: () {
//               if (quantity > 1) {
//                 // Decrease quantity
//                 //  quantity--;
//               }
//             },
//             icon: Icon(Icons.remove_circle),
//           ),
//           Text("${quantity}"),
//           IconButton(onPressed: () {}, icon: Icon(Icons.add_circle))
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../model/cartModel.dart';
import '../singleItem/cartItemWidget.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          return CartItemWidget(cartItem: widget.cartItems[index]);
        },
      ),
    );
  }
}
