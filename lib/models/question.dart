import 'package:flutter/material.dart';

class Question {
  final String question;
  final List<String> upvotes;
  
  Question({
    @required this.question,
    this.upvotes,
  });
}
