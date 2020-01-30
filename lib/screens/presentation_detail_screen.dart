import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rw_symposium_flutter/components/layout.dart';
import 'package:rw_symposium_flutter/utils/helpers.dart';

class PresentationDetailScreen extends StatelessWidget {
  final data;

  PresentationDetailScreen({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: data['title'],
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'speaker-${data['id']}',
              child: Image.network(data['image']),
            ),
            Text(convertStamp(data['time']).toString()),
            Text(
              data['title'],
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(data['description']),
          ],
        ),
      ),
    );
  }
}
