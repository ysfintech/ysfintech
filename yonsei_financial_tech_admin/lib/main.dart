import 'package:flutter/material.dart';
import 'package:ysfintech_admin/screens/home/home_screen.dart';
import 'package:ysfintech_admin/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  User currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routes = {
      '/': (BuildContext context) => Login(),
      '/home': (BuildContext context) => HomeScreen(tap_index: 0),
    };
    if(currentUser == null) {
       return MaterialApp(
          initialRoute: '/',
          routes: routes,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
        );
    } 
    else {
       return MaterialApp(
          initialRoute: '/home',
          routes: routes,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
        );
    }
  }
}
