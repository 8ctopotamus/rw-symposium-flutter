import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = Firestore.instance;

class CurrentUser with ChangeNotifier {
  var _data = null;

  get getUserData {
    return _data;
  }
  
  void setUser(userData) async {
    final user = await _firestore
      .collection('users')
      .document(userData.email)
      .get();


    print(user['username']);

    // _data = userData;
    notifyListeners();
  }
}