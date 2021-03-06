// a scaffold that provides current user info to it's children

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser loggedInUser;

class Layout extends StatefulWidget {
  final String title;
  final Widget child;
  final Widget floatingActionButton;
  final Widget leading;

  Layout({this.title, this.child, this.floatingActionButton, this.leading});

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final _auth = FirebaseAuth.instance;

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.leading,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: widget.child,
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
