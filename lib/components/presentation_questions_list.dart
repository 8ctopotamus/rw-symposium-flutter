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
        .collection('questions')
        .where('presentationID', isEqualTo: widget.presentationID)
        .orderBy('upvotesCount', descending: true)
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
        final questions = snapshot.data.documents;
        List<Widget> questionCards = [];
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
        leading: Column(
          children: <Widget>[
            Text(
              data['upvotesCount'].toString(),
              style: TextStyle(
                fontSize: 26.0,
              ),
            ),
            Text('Upvotes'),
          ],
        ),
        title: Text(data['question']),
        subtitle: Text('Asked by ${data['authorUsername']}, $timeAgo'),
        trailing: IconButton(
          icon: Icon(Icons.arrow_upward),
          tooltip: 'Upvote this question',
          onPressed: () {            
            final DocumentReference questRef = _firestore.document('questions/${data.documentID}');
            _firestore.runTransaction((Transaction tx) async {
              DocumentSnapshot questSnapshot = await tx.get(questRef);
              if (questSnapshot.exists) {
                final authorEmail = questSnapshot.data['authorEmail'];
                List<String> upvotes = List.from(questSnapshot.data['upvotes']);                
                if (upvotes.contains(authorEmail)) {
                  upvotes.remove(authorEmail);
                } else {
                  upvotes.add(authorEmail);
                }
                await tx.update(questRef, <String, dynamic>{
                  'upvotes': upvotes,
                  'upvotesCount': upvotes.length,
                });
              }
            });
          },
        ),
      ), 
    );
  }
}