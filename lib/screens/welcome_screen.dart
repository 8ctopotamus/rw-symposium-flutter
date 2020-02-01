import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rw_symposium_flutter/screens/login_screen.dart';
import 'package:rw_symposium_flutter/screens/registration_screen.dart';
import 'package:rw_symposium_flutter/components/rounded_button';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                // Flexible(
                //     tag: 'logo',
                //     child: Container(
                //       child: 
                //     ),
                //   ),
                // ),

                SvgPicture.asset(
                  'images/logo.svg',
                  semanticsLabel: 'RW Symposium Logo',
                  width: 262,
                ),
                Text(
                  'REAL WEALTH',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 41.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'SYMPOSIUM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  DateTime.now().year.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 118.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.teal,
              text: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              color: Colors.teal,
              text: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
