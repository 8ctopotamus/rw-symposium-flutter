import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rw_symposium_flutter/models/current_user.dart';
import 'package:rw_symposium_flutter/screens/welcome_screen.dart';
import 'package:rw_symposium_flutter/screens/login_screen.dart';
import 'package:rw_symposium_flutter/screens/registration_screen.dart';
import 'package:rw_symposium_flutter/screens/home_screen.dart';
import 'package:rw_symposium_flutter/screens/about_screen.dart';
import 'package:rw_symposium_flutter/screens/create_question_screen.dart';
import 'package:rw_symposium_flutter/constants.dart';

void main() => runApp(RWSymposiumApp());

class RWSymposiumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrentUser>(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          primaryColor: RWColors.turquise,
          backgroundColor: RWColors.darkBlue,
          scaffoldBackgroundColor: RWColors.darkBlue,
          cardColor: Color(0xff29427f),
          appBarTheme: AppBarTheme(
            color: RWColors.turquise,
          ),
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          AboutScreen.id: (context) => AboutScreen(),
          CreateQuestionScreen.id: (context) => CreateQuestionScreen(),
        }
      ),
    );
  }
}
