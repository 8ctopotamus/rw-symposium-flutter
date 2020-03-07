import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rw_symposium_flutter/constants.dart';
import 'package:rw_symposium_flutter/screens/welcome_screen.dart';
import 'package:rw_symposium_flutter/screens/about_screen.dart';
import 'package:rw_symposium_flutter/components/feed.dart';
import 'package:rw_symposium_flutter/components/presentations_list.dart';
import 'package:rw_symposium_flutter/components/user_list.dart';
import 'package:rw_symposium_flutter/models/current_user.dart';

FirebaseUser loggedInUser;

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final _auth = FirebaseAuth.instance;

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  final _widgetOptions = <Widget>[
    PresentationsScreen(),
    Feed(),
    UserList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        Provider.of<CurrentUser>(context, listen: false).setUser(user);
      }
    }
    catch(err) {
      print(err);
      Navigator.pushNamed(context, WelcomeScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Container(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
        ],
        title: Text('RW Symposium ${DateTime.now().year}'),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            title: Text('Program'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed),
            title: Text('Feed'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('People'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: RWColors.greenLight,
        onTap: _onItemTapped,
        backgroundColor: RWColors.darkBlue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.person_outline),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.settings),
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.popAndPushNamed(context, AboutScreen.id);
              },
              leading: Icon(Icons.info_outline),
            ),
            ListTile(
              title: Text('Log out'),
              onTap: () {
                _auth.signOut();
                Provider.of<CurrentUser>(context, listen: false).setUser(null);
                Navigator.popAndPushNamed(context, WelcomeScreen.id);
              },
              leading: Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
