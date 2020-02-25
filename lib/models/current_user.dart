import 'package:flutter/material.dart';

class CurrentUser with ChangeNotifier {
  var _data = null;

  get getUserData {
    return _data;
  }
  
  void setUser(userData) {
    _data = userData;
    notifyListeners();
  }
}