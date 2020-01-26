import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rw_symposium_flutter/components/layout.dart';
import 'package:rw_symposium_flutter/screens/presentation_screen.dart';

final _firestore = Firestore.instance;
final _cloudStorage = FirebaseStorage.instance;

class PresentationsScreen extends StatefulWidget {
  static const String id = 'presentations_screen';

  @override
  _PresentationsScreenState createState() => _PresentationsScreenState();
}

class _PresentationsScreenState extends State<PresentationsScreen> {
  List<Map> presentations = [];

  @override
  void initState() {
    super.initState();
    getPresentations();
  }

  void getPresentations () async {
    final collection = await _firestore.collection('presentations').getDocuments();
    List<Map> docs = [];
    for (var doc in collection.documents) {
      try {
        String url = doc['speaker']['image'];
        var imageURL = await _cloudStorage.ref().child(url).getDownloadURL();
        docs.add({
          ...doc.data,
          'id': doc.documentID,
          'image': imageURL
        });
      } 
      catch (err) {
        print(err);
      }
    }
    setState(() {
      presentations = docs;
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
          return Card(
            child: ListTile(
              leading: Image.network(presentation['image']),
              // Hero(
              //   tag: 'speaker',
              //   child: Image.network(presentation['image']),
              // ),
              title: Text(presentation['title']),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PresentationScreen(data: presentation),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}
