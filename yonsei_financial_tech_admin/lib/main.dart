import 'package:flutter/material.dart';
import 'package:ysfintech_admin/screens/home/home_screen.dart';
import 'package:ysfintech_admin/screens/login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routes = {
      '/': (BuildContext context) => Login(),
      '/home': (BuildContext context) => HomeScreen(),
    };
    return MaterialApp(
      initialRoute: '/',
      routes: routes,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
    );
  }
}
