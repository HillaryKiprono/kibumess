import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FetchActivities extends StatefulWidget {
  const FetchActivities({Key? key}) : super(key: key);

  @override
  _FetchActivitiesState createState() => _FetchActivitiesState();
}

class _FetchActivitiesState extends State<FetchActivities> {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference().child('orders');

  List<Map<dynamic, dynamic>> ordersList = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final DataSnapshot dataSnapshot = await databaseRef.once() as DataSnapshot;
    final Map<dynamic, dynamic>? ordersData = dataSnapshot.value as Map?;
    if (ordersData != null) {
      final List<Map<dynamic, dynamic>> orders = ordersData.values.toList().cast<Map<dynamic, dynamic>>();
      setState(() {
        ordersList = orders;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetched Activities'),
      ),
      body: ordersList.isNotEmpty
          ? ListView.builder(
        itemCount: ordersList.length,
        itemBuilder: (context, index) {
          final order = ordersList[index];
          return ListTile(
            leading: Image.network(order['image']),
            title: Text(order['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price: ${order['price']}'),
                Text('Quantity: ${order['quantity']}'),
                Text('Username: ${order['username']}'),
              ],
            ),
          );
        },
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
