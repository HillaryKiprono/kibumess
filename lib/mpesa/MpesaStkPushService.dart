import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class STKPushScreen extends StatefulWidget {
  @override
  _STKPushScreenState createState() => _STKPushScreenState();
}

class _STKPushScreenState extends State<STKPushScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> initiateSTKPush() async {
    var consumerKey = 'G5wHVIG5KGF1Cb5PPJTuib8ae4MKWUGE';
    var consumerSecret = 'ptBoMzERSOipwDk1';
    var phoneNumber = _phoneNumberController.text.trim();
    var amount = _amountController.text.trim();
    var businessShortCode = '174379';
    var passKey = 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919';
    var accountReference = 'UNIQUE_ACCOUNT_REFERENCE';
    var transactionDescription = 'TRANSACTION_DESCRIPTION';
    var callbackUrl = 'https://mydomain.com/validation';

    var url = 'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
      },
    );

    if (response.statusCode == 200) {
      var accessToken = json.decode(response.body)['access_token'];

      url = 'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest';
      var timeStamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      var password = base64Encode(utf8.encode('$businessShortCode$passKey$timeStamp'));
      var body = {
        'BusinessShortCode': businessShortCode,
        'Password': password,
        'Timestamp': timeStamp,
        'TransactionType': 'CustomerPayBillOnline',
        'Amount': amount,
        'PartyA': phoneNumber,
        'PartyB': businessShortCode,
        'PhoneNumber': phoneNumber,
        'CallBackURL': callbackUrl,
        'AccountReference': accountReference,
        'TransactionDesc': transactionDescription,
      };

      response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        print('STK Push initiated successfully.');
      } else {
        print('Failed to initiate STK Push: ${response.body}');
      }
    } else {
      print('Failed to generate access token: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STK Push Payment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                initiateSTKPush();
              },
              child: Text('Pay with M-Pesa'),
            ),
          ],
        ),
      ),
    );
  }
}
