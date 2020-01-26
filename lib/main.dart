import 'package:flutter/material.dart';
import 'package:rw_symposium_flutter/screens/welcome_screen.dart';
import 'package:rw_symposium_flutter/screens/registration_screen.dart';
import 'package:rw_symposium_flutter/screens/login_screen.dart';
import 'package:rw_symposium_flutter/screens/presentations_screen.dart';

void main() => runApp(RWSymposiumApp());

class RWSymposiumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          PresentationsScreen.id: (context) => PresentationsScreen(),
        }
    );
  }
}
