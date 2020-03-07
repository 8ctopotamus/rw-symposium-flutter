import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rw_symposium_flutter/components/rounded_button';
import 'package:rw_symposium_flutter/screens/home_screen.dart';
import 'package:rw_symposium_flutter/screens/welcome_screen.dart';
import 'package:rw_symposium_flutter/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RWColors.darkBlue,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
              'Log in',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 41.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: kInputDecorationStyle.copyWith(
                hintText: 'Enter your email'
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kInputDecorationStyle.copyWith(
                  hintText: 'Enter your password'
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              color: RWColors.greenLight,
              text: 'Log In',
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                final user = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
                if (user != null) {
                  Navigator.pushNamed(context, HomeScreen.id);
                } else {
                  Navigator.pushNamed(context, WelcomeScreen.id);
                }
                setState(() {
                  showSpinner = false;
                });
              },
            ),
          ],
        ),
      ),
    ),
    );
  }
}
