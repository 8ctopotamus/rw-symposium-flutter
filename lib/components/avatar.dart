import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  AppAvatar({this.name, this.image});
  final String name;
  final String image;
  @override
  Widget build(BuildContext context) {
    final List chunks = name.split(new RegExp('\\s+'));
    final String initials = chunks[0][0] + chunks[1][0];
    return CircleAvatar(
      backgroundImage: image != null ? NetworkImage(image) : null,
      child: image != null ? null : Text(initials),
    );
  }
}