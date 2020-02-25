import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rw_symposium_flutter/screens/user_detail_screen.dart';
import 'package:rw_symposium_flutter/components/avatar.dart';

final _firestore = Firestore.instance;

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List users = [];
  bool showSpinner = true;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    final collection = await _firestore
      .collection('users')
      .orderBy('username')
      .limit(20)
      .getDocuments();
    if (this.mounted) {
      setState(() {
        users = collection.documents;
        showSpinner = false;
      });
    }
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
        itemCount: users.length,
        itemBuilder: (BuildContext context, int idx) {
          final DocumentSnapshot user = users[idx];
          final dynamic designation = user['designation'] != '' 
            ? Text(user['designation']) 
            : null;
          final avatar = user['avatar'] == false 
            ? null 
            : user['avatar'];

          print(user['username']);
          return Card(
            child: ListTile(
              leading: Hero(
                tag: 'user-${user['email']}',
                child: AppAvatar(
                  name: user['username'],
                  image: avatar,
                ),
              ),
              title: Text(user['username']),
              subtitle: designation,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => UserDetailScreen(data: user),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}