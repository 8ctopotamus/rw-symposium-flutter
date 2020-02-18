import 'package:flutter/material.dart';
import 'package:rw_symposium_flutter/constants.dart';

class AppAvatar extends StatelessWidget {
  AppAvatar({
    this.name,
    this.image,
    this.radius,
    this.fontSize,
  });
  final String name;
  final String image;
  final double radius;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    final List chunks = name.split(new RegExp('\\s+'));
    final String initials = chunks[0][0] + chunks[1][0];
    final double mySize = fontSize != null 
      ? fontSize
      : null;
    final myChild = image != null
      ? null
      : Text(initials, style: TextStyle(fontSize: mySize));
    return CircleAvatar(
      backgroundColor: RWColors.greenLight,
      backgroundImage: image != null ? NetworkImage(image) : null,
      child: myChild,
      radius: radius != null ? radius : null,
    );
  }
}