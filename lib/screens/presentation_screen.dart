import 'package:flutter/material.dart';
import 'package:rw_symposium_flutter/components/presentation_detail.dart';
import 'package:rw_symposium_flutter/components/presentation_questions_list.dart';
import 'package:rw_symposium_flutter/components/reviews_list.dart';
import 'package:rw_symposium_flutter/screens/create_question_screen.dart';
import 'package:rw_symposium_flutter/screens/create_review_screen.dart';
import 'package:rw_symposium_flutter/constants.dart';

class PresentationScreen extends StatefulWidget {
  final data;

  PresentationScreen({@required this.data});

  _PresentationScreenState createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    var fab;
    if (_index == 1) {
      fab = FloatingActionButton(
        backgroundColor: RWColors.turquise,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CreateQuestionScreen(presentationID: data['id']),
          ));
        },
      );
    } else if (_index == 2) {
      fab = FloatingActionButton(
        backgroundColor: RWColors.turquise,
        child: Icon(
          Icons.star,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CreateReviewScreen(presentationID: data['id']),
          ));
        },
      );
    }

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
            ],
            onTap: (i) {
              setState(() {
                _index = i;
              });
            },
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            PresentationDetails(data: data),
            PresentationQuestionsList(presentationID: data['id']),
            ReviewsList(presentationID: data['id']),
          ],
        ),
        floatingActionButton: fab,
      ),
    );
  }
}