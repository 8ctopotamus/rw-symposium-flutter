import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rw_symposium_flutter/components/layout.dart';
import 'package:rw_symposium_flutter/utils/helpers.dart';

class PresentationDetailScreen extends StatelessWidget {
  final data;

  PresentationDetailScreen({@required this.data});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(data['title']),
          backgroundColor: Colors.teal,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.info), text: 'Details',),
              Tab(icon: Icon(Icons.question_answer), text: 'Questions',),
              Tab(icon: Icon(Icons.star), text: 'Review',),
            ]
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            // info
            SingleChildScrollView(
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
            Center(child: Text('Questions'),),
            Center(child: Text('Reviews'),),
          ],
        ),
      ),
    );
  }
}