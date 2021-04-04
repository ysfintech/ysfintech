import 'package:flutter/material.dart';
// header
import 'package:yonsei_financial_tech/header/header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yonsei Univ. Financial Technology Center',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: Header()
    );
  }
}