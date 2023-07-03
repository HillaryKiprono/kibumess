class CartItem {
  final String image;
  final String name;
  final double price;
  final int quantity;
  final String username;

  CartItem( {
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.username,
  });

  factory CartItem.fromJson(Map<dynamic, dynamic> json) {
    return CartItem(
      image: json['image'] as String,
      name: json['name'] as String,
      price: (json['price'] as int).toDouble(), // Convert int to double
      quantity: json['quantity'] as int,
      username: json['username'] as String
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}
