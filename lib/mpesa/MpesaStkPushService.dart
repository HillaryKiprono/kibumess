import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';
class MpesaStkPush extends StatefulWidget {
  const MpesaStkPush({super.key, required this.totalAmount});

  createState() => MpesaStkPushState();
  final double totalAmount;
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

  // void _showInputDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text("Enter Phone Number and Amount"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: _phoneNumberController,
  //               keyboardType: TextInputType.phone,
  //               decoration: const InputDecoration(labelText: 'Phone Number'),
  //             ),
  //             const SizedBox(height: 16),
  //             TextField(
  //               controller: _amountController,
  //               keyboardType: TextInputType.number,
  //               decoration: const InputDecoration(labelText: 'Amount'),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               lipaNaMpesa();
  //               Navigator.pop(context); // Close the dialog
  //             },
  //             child: const Text("Submit"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  Widget build(BuildContext context) {
    double totalAmt=widget.totalAmount;
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
            padding: EdgeInsets.all(20),
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
                  SizedBox(height: 16.0),
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