import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

final _firestore = Firestore.instance;

class Comments extends StatefulWidget {
  final postID;
  
  Comments({@required this.postID});
  
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
        .collection('comments')
        .where('postID', isEqualTo: widget.postID)
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
            child: Text('Be the first to leave a comment.'),
          );
        }
        final comments = snapshot.data.documents;
        List<Widget> commentCards = [];
        for (var c in comments) {
          commentCards.add(CommentCard(data: c));
        }
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: commentCards,
        );
      },
    );
  }
}

class CommentCard extends StatelessWidget {
  CommentCard({@required this.data});
  final data;
  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.fromMillisecondsSinceEpoch(data['createdAt']); 
    final timeAgo = timeago.format(createdAt);
    return Card(
      child: ListTile(
        title: Text(data['text']),
        subtitle: Text('${data['authorUsername']}, $timeAgo'),
        // trailing: IconButton(
        //   icon: Icon(Icons.thumb_up),
        //   tooltip: 'Like comment',
        //   onPressed: () {            
        //     final DocumentReference commentRef = _firestore.document('comments/${data.documentID}');
        //     _firestore.runTransaction((Transaction tx) async {
        //       DocumentSnapshot questSnapshot = await tx.get(commentRef);
        //       if (questSnapshot.exists) {
        //         final authorEmail = questSnapshot.data['authorEmail'];
        //         List<String> likes = List.from(questSnapshot.data['likes']);                
        //         if (likes.contains(authorEmail)) {
        //           likes.remove(authorEmail);
        //         } else {
        //           likes.add(authorEmail);
        //         }
        //         await tx.update(commentRef, <String, dynamic>{
        //           'likes': likes,
        //         });
        //       }
        //     });
        //   },
        // ),
      ), 
    );
  }
}