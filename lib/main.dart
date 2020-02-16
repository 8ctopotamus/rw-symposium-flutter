import 'package:flutter/material.dart';
import 'package:rw_symposium_flutter/constants.dart';
import 'package:rw_symposium_flutter/screens/welcome_screen.dart';
import 'package:rw_symposium_flutter/screens/login_screen.dart';
import 'package:rw_symposium_flutter/screens/registration_screen.dart';
import 'package:rw_symposium_flutter/screens/event_screen.dart';

void main() => runApp(RWSymposiumApp());

class RWSymposiumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: RWColors.turquise,
        backgroundColor: RWColors.darkBlue,
        scaffoldBackgroundColor: RWColors.darkBlue,
        cardColor: Color(0xff29427f),
        appBarTheme: AppBarTheme(
          color: RWColors.green,
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        EventScreen.id: (context) => EventScreen(),
      }
    );
  }
}
