import 'package:flutter/material.dart';

class RWColors {
  static const Color darkBlue = Color(0xff1e305d);
  static const Color turquise = Color(0xff0885a2);
  static const Color green = Color(0xff2a676a);
  static const Color greenLight = Color(0xff44b8ba);
  static const Color red = Color(0xfff15d5e);
}

const kSendButtonTextStyle = TextStyle(
  color: Colors.tealAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kInputDecorationStyle = InputDecoration(
  filled: true,
  // fillColor: Colors.white,
  hintText: 'Enter a value',
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: RWColors.turquise, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: RWColors.greenLight, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);