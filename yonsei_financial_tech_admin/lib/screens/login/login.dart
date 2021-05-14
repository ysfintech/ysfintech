import 'package:flutter/material.dart';
import 'package:ysfintech_admin/screens/home/home_screen.dart';
import 'package:ysfintech_admin/utils/color_constants.dart';
// firebase auth
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;

  // text controller
  TextEditingController emailController, passwordController;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              FirebaseAuth.instance.setPersistence(Persistence.SESSION))
          .then((value) => Navigator.pushNamed(context, '/home'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('입력한 계정을 찾을 수 없습니다.')));
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('비밀번호가 올바르지 않습니다.')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      controller: emailController,
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      controller: passwordController,
    );

    final loginButton = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ElevatedButton(
        onPressed: () => signIn(emailController.text, passwordController.text),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12),
            primary: ColorConstants.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: Text('Log In',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: ColorConstants.blue,
              ),
            ],
          ),
          Center(
            child: Card(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(42),
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 62.0),
                    Center(
                        child: Text(
                      "ysfintech admin",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    SizedBox(height: 48.0),
                    email,
                    SizedBox(height: 8.0),
                    password,
                    SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value;
                                });
                              },
                            ),
                            Text("Remember Me")
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 18.0),
                    loginButton,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
