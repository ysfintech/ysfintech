import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ysfintech_admin/bindings/auth_binding.dart';
import 'package:ysfintech_admin/bindings/board_binding.dart';
import 'package:ysfintech_admin/bindings/intro_edu_binding.dart';
import 'package:ysfintech_admin/bindings/project_binding.dart';
import 'package:ysfintech_admin/bindings/sigin_binding.dart';

import 'package:ysfintech_admin/controllers/auth_controller.dart';
import 'package:ysfintech_admin/screens/collaboration.dart';

import 'package:ysfintech_admin/screens/home/home_screen.dart';
import 'package:ysfintech_admin/screens/introduction_edit.dart';
import 'package:ysfintech_admin/screens/introduction.dart';
import 'package:ysfintech_admin/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ysfintech_admin/screens/projects.dart';

import 'screens/home/home_grid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init firebase and current user
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(Home());
}

// class MyApp extends StatelessWidget {
//   User currentUser = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     Map<String, WidgetBuilder> routes = {
//       '/': (BuildContext context) => Login(),
//       '/home': (BuildContext context) => HomeScreen(tap_index: 0),
//     };
//     if (currentUser == null) {
//       return MaterialApp(
//         initialRoute: '/',
//         routes: routes,
//         debugShowCheckedModeBanner: false,
//         title: 'ysfintech admin',
//       );
//     } else {
//       return MaterialApp(
//         initialRoute: '/home',
//         routes: routes,
//         debugShowCheckedModeBanner: false,
//         title: 'ysfintech admin',
//       );
//     }
//   }
// }

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Yonsei Fintech Admin Page',
      initialRoute: '/',
      unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),
      getPages: [
        GetPage(
          name: '/',
          page: () => SignInScreen(),
          binding: SignInBinding(),
        ),
        // GetPage(name: '/home', page: () => HomeScreen(tap_index: 0)),
        GetPage(
          name: '/home',
          page: () => HomeGridViewScreen(),
          // binding: AuthBinding(),
        ),
        GetPage(
            name: '/home/intro_edu',
            page: () => IntroEduScreen(),
            binding: IntroEduBinding()),
        GetPage(
          name: '/home/project',
          page: () => ProjectScreen(),
          binding: ProjectBinding(),
        ),
        GetPage(
          name: '/home/collaboration',
          page: () => CollaborationScreen(),
          binding: CollaborationBinding(),
        ),
      ],
      defaultTransition: Transition.zoom,
    );
  }
}

class UnknownRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('NOT FOUND'),
          TextButton(
            onPressed: () => Get.toNamed('/'),
            child: Text('GO'),
          ),
        ],
      )),
    );
  }
}

class Done extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Success'),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: AuthController.instance.signOut,
        child: Text('LOG-OUT'),
      ),
    );
  }
}
