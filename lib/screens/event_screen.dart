import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rw_symposium_flutter/constants.dart';
import 'package:rw_symposium_flutter/screens/welcome_screen.dart';
import 'package:rw_symposium_flutter/components/feed.dart';
import 'package:rw_symposium_flutter/components/presentations_list.dart';
import 'package:rw_symposium_flutter/components/user_list.dart';

FirebaseUser loggedInUser;

class EventScreen extends StatefulWidget {
  static String id = 'event_screen';

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
      appBar: AppBar(
        leading: Container(),
        backgroundColor: RWColors.greenLight,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
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
            title: Text('Talks'),
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
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
        backgroundColor: RWColors.darkBlue,
      ),
    );
  }
}
