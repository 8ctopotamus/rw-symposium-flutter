import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:rw_symposium_flutter/components/avatar.dart';

final _firestore = Firestore.instance;

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    // use #RWAS2020 and tag @RealWealthMKTG when you share to FB, LI, TW
    return StreamBuilder(
      stream: _firestore
        .collection('feed')
        .orderBy('createdAt')
        .limit(20)
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
            child: Text('Be the first to post.'),
          );
        }
        final questions = snapshot.data.documents.reversed;
        List<PostCard> postCards = [];
        for (var q in questions) {
          postCards.add(PostCard(data: q));
        }
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: postCards,
        );
      },
    );
  }
}

class PostCard extends StatelessWidget {
  PostCard({@required this.data});
  final data;
  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.fromMillisecondsSinceEpoch(data['createdAt']); 
    final timeAgo = timeago.format(createdAt);
    List<Widget> cardWidgets = [
      Row(
        children: <Widget>[
          AppAvatar(
            name: data['authorUsername'],
            // image: data['authorAvatar'] ? data['authorAvatar'] : null,
          ),
          Column(
            children: <Widget>[
              Text(data['authorUsername']),
              Text(timeAgo),
            ],
          ),
        ],
      ),
      Text(data['text']),
      Text('Likes: ${data['likes'].length}'),
      Text('Comments'),
    ];
    // if (data['image'] != false) {
    //   cardWidgets.insert(1, Image.network(data['image']));
    // }
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: cardWidgets,
        ),
      )
    );
  }
}