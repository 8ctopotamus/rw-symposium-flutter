import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:rw_symposium_flutter/components/avatar.dart';
import 'package:rw_symposium_flutter/screens/create_comment_screen.dart';
import 'package:rw_symposium_flutter/models/current_user.dart';

final _firestore = Firestore.instance;

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser>(context, listen: false).getUserData;
    // use #RWAS2020 and tag @RealWealthMKTG when you share to FB, LI, TW
    return StreamBuilder(
      stream: _firestore
        .collection('posts')
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
        final posts = snapshot.data.documents.reversed;
        List<PostCard> postCards = [];
        for (var p in posts) {
          postCards.add(PostCard(data: p, currentUser: currentUser));
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
  PostCard({@required this.data, @required this.currentUser});
  
  final data;
  final currentUser;

  _toggleLikePost() {
    final DocumentReference questRef = _firestore.document('posts/${data.documentID}');
    _firestore.runTransaction((Transaction tx) async {
      DocumentSnapshot questSnapshot = await tx.get(questRef);
      if (questSnapshot.exists) {
        List<String> likes = List.from(questSnapshot.data['likes']);                
        if (likes.contains(currentUser.documentID)) {
          likes.remove(currentUser.documentID);
        } else {
          likes.add(currentUser.documentID);
        }
        await tx.update(questRef, <String, dynamic>{
          'likes': likes,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.fromMillisecondsSinceEpoch(data['createdAt']); 
    final timeAgo = timeago.format(createdAt);
    final liked = data['likes'].toString();

    // final currentUser = Provider.of<CurrentUser>(context, listen: false).getUserData;

    List<Widget> cardWidgets = [
      Row(
        children: <Widget>[
          AppAvatar(
            name: data['authorUsername'],
            image: data['authorAvatar'],
          ),
          SizedBox(width: 10.0),
          Column(
            children: <Widget>[
              Text(data['authorUsername']),
              Text(timeAgo),
            ],
          ),
        ],
      ),
      SizedBox(height: 5.0,),
      Text(data['text']),
      SizedBox(height: 10.0,),
      Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.thumb_up),
            tooltip: 'Likes',
            onPressed: _toggleLikePost,
          ),
          Text(data['likes'].length.toString()),
          SizedBox(width: 30.0),
          IconButton(
            icon: Icon(Icons.chat),
            tooltip: 'Comments',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CreateCommentScreen(postID: data.documentID),
              ));
            },
          ),
        ],
      ),
    ];
    if (data['image'] != null) {
      cardWidgets.insert(1, Image.network(data['image'], fit: BoxFit.contain));
    }
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: cardWidgets,
        ),
      )
    );
  }
}