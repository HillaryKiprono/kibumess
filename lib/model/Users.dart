class Users {
  String name;
  String password;
  String phone;
  String image;
  String address;

  Users({
    required this.name,
    required this.password,
    required this.phone,
    required this.image,
    required this.address,
  });

  factory Users.fromJson(Map<dynamic, dynamic> json) {
    return Users(
      name: json['name'],
      password: json['password'],
      phone: json['phone'],
      image: json['image'],
      address: json['address'],
    );
  }
}
