import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rw_symposium_flutter/components/layout.dart';
import 'package:rw_symposium_flutter/components/rounded_button';
import 'package:rw_symposium_flutter/models/current_user.dart';
import 'package:rw_symposium_flutter/screens/camera_screen.dart';
import 'package:rw_symposium_flutter/constants.dart';

final Firestore _firestore = Firestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

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

  _navigateAndDisplayCameraScreen(BuildContext context) async {
    image = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context, listen: false).getUserData;
    String authorAvatar = user['avatar'];
    String storageUrl;

    Widget imageControl = image == null 
      ? RoundedButton(
          color: Colors.transparent,
          text: 'Attach image',
          onPressed: () async {
            _navigateAndDisplayCameraScreen(context);
          },
        )
      : SizedBox(
        child: Image.file(File(image)),
        height: 300.0,
      );

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
            
            imageControl,
            
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

                if (image != null) {
                  List parts = image.split('/');
                  String fileName = parts.last;
                  final StorageReference storageReference = _storage.ref().child('user-content/${user['email']}/post-$fileName');
                  final StorageUploadTask uploadTask = storageReference.putFile(File(image));
                  final StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event) {
                    print('EVENT ${event.type}');
                  });
                  final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
                  streamSubscription.cancel();
                  storageUrl = (await downloadUrl.ref.getDownloadURL());
                }
                try {
                  await reviewsRef.add({
                    'createdAt': DateTime.now().toUtc().millisecondsSinceEpoch,
                    'authorAvatar': authorAvatar,
                    'authorUsername': user['username'],
                    'authorEmail': user['email'],
                    'likes': [],
                    'image': storageUrl != null ? storageUrl : null,
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