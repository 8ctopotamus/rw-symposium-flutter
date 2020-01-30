import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore = Firestore.instance;

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List posts = [];
  bool showSpinner = true;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    final collection = await _firestore
      .collection('feed')
      .limit(20)
      .getDocuments();
    setState(() {
      posts = collection.documents;
      showSpinner = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int idx) {
          final post = posts[idx];
          return Card(
            child: ListTile(
              title: Text(post['text']),
              onTap: null,
            ),
          );
        },
      ),
    );
  }
}