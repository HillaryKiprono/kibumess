import 'package:flutter/material.dart';

import '../model/cartModel.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: Image.network(cartItem.image,width: 100,),
      title: Text(cartItem.name),
      subtitle: Text('Price: ksh${cartItem.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: (){
            if (cartItem.quantity > 1) {
              // Decrease quantity
              cartItem.quantity--;
            }
          }, icon: Icon(Icons.remove_circle),

          ),
          Text("${cartItem.quantity}"),
          IconButton(onPressed: (){}, icon: Icon(Icons.add_circle))
        ],

      ),
    );
  }
}
