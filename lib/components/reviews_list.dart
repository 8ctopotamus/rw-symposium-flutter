import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:rw_symposium_flutter/constants.dart';

final _firestore = Firestore.instance;

class ReviewsList extends StatefulWidget {
  final presentationID;
  ReviewsList({@required this.presentationID});  
  @override
  _ReviewsListState createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
        .collection('reviews')
        .where('presentationID', isEqualTo: widget.presentationID)
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
            child: Text('Be the first to leave a review.'),
          );
        }
        final questions = snapshot.data.documents.reversed;
        List<RatingCard> ratingCards = [];
        for (var r in questions) {
          ratingCards.add(RatingCard(data: r));
        }
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: ratingCards,
        );
      },
    );
  }
}

class RatingCard extends StatelessWidget {
  RatingCard({@required this.data});
  final data;
  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.fromMillisecondsSinceEpoch(data['createdAt']); 
    final timeAgo = timeago.format(createdAt);
    List<Widget> stars = [];
    for (int i = 0; i < data['rating']; i++) {
      stars.add(Icon(Icons.star, color: Colors.yellow,));
    }
    stars.add(Text('${data['rating'].toString()}/5'));
    return Card(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${data['authorUsername']}, $timeAgo'),
            SizedBox(height: 10.0,),
            Row( children: stars, ),
            Divider(
              color: Colors.white,
              height: 20.0
            ),
            Text(
              'Best thing I learned:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 10.0,),
            Text(data['bestThingLearned'], style: bodyTextStyle,),
            Divider(
              color: Colors.white,
              height: 20.0
            ),
            Text(
              'Best thing I learned:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(data['howToImprove'], style: bodyTextStyle,),
          ],
        ),
      ),
    );
  }
}
