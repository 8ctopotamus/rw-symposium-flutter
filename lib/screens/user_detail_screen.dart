import 'package:flutter/material.dart';
import 'package:rw_symposium_flutter/components/layout.dart';
import 'package:rw_symposium_flutter/components/avatar.dart';


class UserDetailScreen extends StatelessWidget {
  final data;

  UserDetailScreen({@required this.data});

  @override
  Widget build(BuildContext content) {
    final avatar = data['avatar'] == false 
      ? null 
      : data['avatar'];
    return Layout(
      title: data['username'],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: 'user-${data['email']}',
            child: AppAvatar(
              name: data['username'],
              image: avatar,
              radius: 100.0,
              fontSize: 80.0,
            ),
          ),
          Text(data['username']),
          Text(data['designation']),
          Text(data['avatar'].toString()),
          Text(data['points'].toString()),
          Text(data['email']),
          Text(data['phone']),
          Text(data['website']),
          Text(data['bio']),
        ],
      ),
    );
  }
}
