import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rw_symposium_flutter/components/layout.dart';
import 'package:rw_symposium_flutter/components/rounded_button';
import 'package:rw_symposium_flutter/models/current_user.dart';
import 'package:rw_symposium_flutter/screens/camera_screen.dart';
import 'package:rw_symposium_flutter/constants.dart';

final _firestore = Firestore.instance;

class CreatePostScreen extends StatefulWidget {  
  CreatePostScreen({this.presentationID});
  static const String id = 'create_post_screen';
  final String presentationID;
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool showSpinner = false;
  String text;
  String authorAvatar = null;
  String image = null;
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context, listen: false).getUserData;
    authorAvatar = user['avatar'];
    return Layout(
      title: 'Write a post',
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            TextField(
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.center,
              onChanged: (value) {
                text = value;
              },
              decoration: kInputDecorationStyle.copyWith(
                hintText: 'What are you thinking?'
              ),
            ),
            
            SizedBox(
              height: 8.0,
            ),

            RoundedButton(
              color: Colors.transparent,
              text: 'Attach image',
              onPressed: () async {
                Navigator.pushNamed(context, CameraScreen.id);
              },
            ),

            SizedBox(
              height: 8.0,
            ),
            
            RoundedButton(
              color: RWColors.turquise,
              text: 'Post',
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                final reviewsRef = _firestore.collection('posts');
                try {
                  await reviewsRef.add({
                    'createdAt': DateTime.now().toUtc().millisecondsSinceEpoch,
                    'authorAvatar': authorAvatar,
                    'authorUsername': user['username'],
                    'authorEmail': user['email'],
                    'likes': [],
                    // 'image': image,
                    'text': text,
                  });
                } catch(err) {
                  print('[Firebase error]: $err');
                }
                setState(() {
                  showSpinner = false;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}