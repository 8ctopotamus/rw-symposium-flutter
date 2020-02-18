import 'package:flutter/material.dart';
import 'package:rw_symposium_flutter/components/presentation_detail.dart';
import 'package:rw_symposium_flutter/components/presentation_questions_list.dart';
import 'package:rw_symposium_flutter/components/reviews_list.dart';

class PresentationScreen extends StatelessWidget {
  final data;

  PresentationScreen({@required this.data});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(data['title']),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.info), text: 'Details',),
              Tab(icon: Icon(Icons.question_answer), text: 'Questions',),
              Tab(icon: Icon(Icons.star), text: 'Reviews',),
            ]
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            PresentationDetails(data: data),
            PresentationQuestionsList(presentationID: data['id']),
            ReviewsList(presentationID: data['id']),
          ],
        ),
      ),
    );
  }
}