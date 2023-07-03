class CartItemData {
  String image;
  String name;
  String username;
  double price;
  int quantity;

  CartItemData({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.username


  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'price': price,
      'quantity': quantity,
      'username':username,

    };
  }

  factory CartItemData.fromJson(Map<String, dynamic> json) {
    return CartItemData(
      image: json['image'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      username: json['username'],

    );
  }

}