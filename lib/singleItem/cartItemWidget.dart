import 'package:flutter/material.dart';
import '../model/cartModel.dart';

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
      subtitle: Text('Price: ksh$price'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              if (quantity > 1) {
                // Decrease quantity
                // quantity--;
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
