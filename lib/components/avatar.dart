import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final String name;
  final String image;

  AppAvatar({this.name, this.image});

  @override
  Widget build(BuildContext context) {
    final List chunks = name.split(new RegExp('\\s+'));
    final String initials = chunks[0][0] + chunks[1][0];
    print(image);
    return CircleAvatar(
      backgroundImage: image != null ? NetworkImage(image) : null,
      child: image != null ? null : Text(initials),
    );
  }
}