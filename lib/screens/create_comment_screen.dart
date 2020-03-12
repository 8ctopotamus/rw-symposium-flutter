import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rw_symposium_flutter/components/layout.dart';
import 'package:rw_symposium_flutter/constants.dart';
import 'package:rw_symposium_flutter/models/current_user.dart';
import 'package:rw_symposium_flutter/components/comments.dart';

final _firestore = Firestore.instance;

class CreateCommentScreen extends StatefulWidget {  
  CreateCommentScreen({this.postID});
  static const String id = 'create_comment_screen';
  final String postID;
  _CreateCommentScreenState createState() => _CreateCommentScreenState();
}

class _CreateCommentScreenState extends State<CreateCommentScreen> {
  String comment;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CurrentUser>(context, listen: false).getUserData;

    return Layout(
      title: 'Write a comment',
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Comments(postID: widget.postID),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        comment = value;
                      },
                      decoration: kInputDecorationStyle.copyWith(
                        hintText: 'Write a comment'
                      ),
                    ),
                  ),
                  FlatButton(
                    color: RWColors.turquise,
                    child: Icon(Icons.send),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      final commentsRef = _firestore.collection('comments');
                      try {
                        await commentsRef.add({
                          'postID': widget.postID,
                          'text': comment,
                          'createdAt': DateTime.now().toUtc().millisecondsSinceEpoch,
                          'authorUsername': user['username'],
                          'authorEmail': user.documentID,
                          'likes': [],
                        });
                      } catch(err) {
                        print('[Firebase error]: $err');
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}