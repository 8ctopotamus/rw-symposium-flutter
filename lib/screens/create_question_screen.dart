import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rw_symposium_flutter/components/layout.dart';
import 'package:rw_symposium_flutter/components/rounded_button';
import 'package:rw_symposium_flutter/constants.dart';
import 'package:rw_symposium_flutter/models/current_user.dart';

final _firestore = Firestore.instance;

class CreateQuestionScreen extends StatefulWidget {  
  CreateQuestionScreen({this.presentationID});

  static const String id = 'create_question_screen';
  final String presentationID;

  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  String question;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CurrentUser>(context, listen: false).getUserData;

    return Layout(
      title: 'Ask a question',
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            TextField(
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.center,
              onChanged: (value) {
                question = value;
              },
              decoration: kInputDecorationStyle.copyWith(
                hintText: 'What is your question?'
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            RoundedButton(
              color: RWColors.greenLight,
              text: 'Ask question',
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                final questionsRef = _firestore.collection('questions');
                try {
                  await questionsRef.add({
                    'presentationID': widget.presentationID,
                    'question': question,
                    'createdAt': DateTime.now().toUtc().millisecondsSinceEpoch,
                    'authorUsername': user['username'],
                    'authorEmail': user['email'],
                    'upvotesCount': 0,
                    'upvotes': [],
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