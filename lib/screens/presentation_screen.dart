import 'package:flutter/material.dart';
import 'package:rw_symposium_flutter/components/layout.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

DateTime _convertStamp(Timestamp _stamp) {
  if (_stamp != null) {
    return Timestamp(_stamp.seconds, _stamp.nanoseconds).toDate();
    /*
    if (Platform.isIOS) {
      return _stamp.toDate();
    } else {
      return Timestamp(_stamp.seconds, _stamp.nanoseconds).toDate();
    }
    */
  } else {
    return null;
  }
}


class PresentationScreen extends StatelessWidget {
  final data;

  PresentationScreen({this.data});

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
            Text(_convertStamp(data['time']).toString()),
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
