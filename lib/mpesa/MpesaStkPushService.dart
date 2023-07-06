import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/cart_item.dart';
class MpesaStkPush extends StatefulWidget {
  const MpesaStkPush({super.key, required this.totalAmount, required this.cartItems, required this.username});

  createState() => MpesaStkPushState();
  final double totalAmount;
  final String username;
  final List<CartItem> cartItems;
}
class MpesaStkPushState extends State<MpesaStkPush> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _amountController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.totalAmount.toString());
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> lipaNaMpesa() async {
    dynamic transactionInitialisation;
    // Initialize the Firebase Realtime Database reference
    final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

    // Save cart items to the "orders" table
    for (final CartItem item in widget.cartItems) {
      final DatabaseReference orderRef = databaseRef.child('orders').push();
      orderRef.set({
        'food_name': item.name,
        'price': item.price,
        'quantity': item.quantity,
        'totalAmount': widget.totalAmount,
        'phone_number': _phoneNumberController.text,
        'username': widget.username,
      });
    }
    try {

      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: double.parse(_amountController.text),
        partyA: "254797275814",
        partyB: "174379",
        callBackURL: Uri(scheme: "https", host: "mpesa-requestbin.herokuapp.com", path: "/1hhy6391"),
        accountReference: "Kibu Mess",
        phoneNumber: _phoneNumberController.text,
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: "purchase",
        passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",

      );

      return transactionInitialisation;
    } catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF481E4D)),
      home: Scaffold(
        backgroundColor: Colors.white54,
        appBar: AppBar(
          title: const Text('Mpesa Payment'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white

            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Enter Phone Number eg 2547.....',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(

                    controller: _amountController,
                    keyboardType: TextInputType.number,
                   readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      lipaNaMpesa();
                    },
                    child: const Text(
                      "Lipa na Mpesa",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


