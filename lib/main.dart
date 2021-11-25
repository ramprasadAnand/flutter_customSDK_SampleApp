import 'package:flutter/material.dart';
import 'package:razorpay_flutter_customui/razorpay_flutter_customui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Razorpay? _razorpay;
  String key = 'rzp_live_ILgsfZCZoFIKMb';

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay?.initilizeSDK(key);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    super.initState();
  }

  void _handlePaymentSuccess(Map<dynamic, dynamic> response) {
    print('Success Flutter Custom SDK : $response');
  }

  void _handlePaymentError(Map<dynamic, dynamic> response) {
    print('Error Flutter Custom SDK : $response');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open Checkout'),
          onPressed: () async {
            final isValidVPA = await _razorpay?.isValidVpa('9663976539@upi');
            print(isValidVPA);
            var options = {
              "key": key,
              "amount": 100,
              "currency": "INR",
              "email": "ramprasad179@gmail.com",
              "contact": "9663976539",
              "method": "upi",
              "_[flow]": "collect",
              "vpa": "9663976539@upi"
            };
            _razorpay?.submit(options);
          },
        ),
      ),
    );
  }
}
