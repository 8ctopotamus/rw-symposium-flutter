import 'package:flutter/material.dart';
import 'package:rw_symposium_flutter/components/layout.dart';

class UserDetailScreen extends StatelessWidget {
  final data;

  UserDetailScreen({@required this.data});

  @override
  Widget build(BuildContext content) {
    return Layout(
      title: data['username'],
      child: Column(
        children: <Widget>[
          Text(data['username']),
          Text(data['designation']),
          Text(data['avatar']),
          Text(data['points']),
          Text(data['email']),
          Text(data['phone']),
          Text(data['website']),
          Text(data['bio']),
        ],
      ),
    );
  }
}