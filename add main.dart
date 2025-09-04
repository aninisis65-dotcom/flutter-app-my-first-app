import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("KDP Sizes App")),
        body: Center(
          child: Text(
            "مرحباً بك في أول تطبيق Flutter 🚀",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
