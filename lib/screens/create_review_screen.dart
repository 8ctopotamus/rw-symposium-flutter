import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rw_symposium_flutter/components/layout.dart';
import 'package:rw_symposium_flutter/components/rounded_button';
import 'package:rw_symposium_flutter/models/current_user.dart';
import 'package:rw_symposium_flutter/constants.dart';

final _firestore = Firestore.instance;

class CreateReviewScreen extends StatefulWidget {  
  CreateReviewScreen({this.presentationID});
  static const String id = 'create_review_screen';
  final String presentationID;
  _CreateReviewScreenState createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  int rating = 0;
  String bestThingLearned;
  String howToImprove;
  bool showSpinner = false;
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context, listen: false).getUserData;
    final List<Widget> stars = [];
    for (int i = 1; i < 6; i++) {
      final color = i <= rating ? Colors.yellow : Colors.white;
      stars.add(
        IconButton(
          icon: Icon(
            Icons.star,
            color: color,
            size: 30.0,
          ),
          onPressed: () {
            setState(() {
              rating = i;
            }); 
          },
        )
      );
    }
    stars.add(Text(rating.toString()));
    return Layout(
      title: 'Leave a review',
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            Text('How many stars would you give this presentation?'),
            Row(
              children: stars,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.center,
              onChanged: (value) {
                bestThingLearned = value;
              },
              decoration: kInputDecorationStyle.copyWith(
                hintText: 'What\'s the one best thing you got out of this presentation?'
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.center,
              onChanged: (value) {
                howToImprove = value;
              },
              decoration: kInputDecorationStyle.copyWith(
                hintText: 'What are you going to do differently now that you have heard these ideas?'
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            RoundedButton(
              color: RWColors.turquise,
              text: 'Leave review',
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                final reviewsRef = _firestore.collection('reviews');
                try {
                  await reviewsRef.add({
                    'presentationID': widget.presentationID,
                    'createdAt': DateTime.now().toUtc().millisecondsSinceEpoch,
                    'authorUsername': user['username'],
                    'authorEmail': user['email'],
                    'bestThingLearned': bestThingLearned,
                    'howToImprove': howToImprove,
                    'rating': rating,
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
// keyboardType: TextInputType.multiline,