import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rw_symposium_flutter/components/layout.dart';

final _firestore = Firestore.instance;

class PresentationsScreen extends StatefulWidget {
  static const String id = 'presentations_screen';

  @override
  _PresentationsScreenState createState() => _PresentationsScreenState();
}

class _PresentationsScreenState extends State<PresentationsScreen> {
  final _auth = FirebaseAuth.instance;
  List<DocumentSnapshot> presentations = [];

  @override
  void initState() {
    super.initState();
    getPresentations();
  }

  void getPresentations () async {
    final docs = await _firestore.collection('presentations').getDocuments();

//    for (var doc in docs.documents) {
//      print(doc.documentID);
//    }

    setState(() {
      presentations = docs.documents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Presentations',
      child: ListView.builder(
        itemCount: presentations.length,
        itemBuilder: (BuildContext context, int idx) {
          final presentation = presentations[idx];
          final String id = presentation.documentID;
          final data = presentation.data;
          return Card(
            child: ListTile(
              leading: Text('Image'),
              title: Text(data['title']),
              onTap: () {
                print(id);
              },
            ),
          );
        },
      ),
    );
  }
}
