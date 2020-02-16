import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

final _firestore = Firestore.instance;

class PresentationQuestionsList extends StatefulWidget {
  final presentationID;
  
  PresentationQuestionsList({@required this.presentationID});
  
  @override
  _PresentationQuestionsListState createState() => _PresentationQuestionsListState();
}

class _PresentationQuestionsListState extends State<PresentationQuestionsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
        .collection('presentations/${widget.presentationID}/questions')
        .orderBy('upvotesCount')
        .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        if (snapshot.data.documents.length == 0) {
          return Center(
            child: Text('Be the first to ask a question.'),
          );
        }
        final questions = snapshot.data.documents.reversed;
        List<QuestionCard> questionCards = [];
        for (var q in questions) {
          questionCards.add(QuestionCard(data: q));
        }
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: questionCards,
        );
      },
    );
  }
}

class QuestionCard extends StatelessWidget {
  QuestionCard({@required this.data});
  final data;
  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.fromMillisecondsSinceEpoch(data['createdAt']); 
    final timeAgo = timeago.format(createdAt);
    return Card(
      child: ListTile(
        title: Text(data['question']),
        subtitle: Text('Asked by ${data['user']['username']} $timeAgo'),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_upward),
              tooltip: 'Upvote this question',
              onPressed: () {
                print('Upvoting question...');
              },
            ),
            // Text('${data['upvotes'].length.toString()} Upvotes'),
          ],
        ),
      ), 
    );
  }
}