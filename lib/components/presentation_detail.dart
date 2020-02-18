import 'package:flutter/material.dart';
import 'package:rw_symposium_flutter/constants.dart';
import 'package:rw_symposium_flutter/utils/helpers.dart';

class PresentationDetails extends StatelessWidget {
  PresentationDetails({@required this.data});

  final data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'speaker-${data['id']}',
            child: Image.network(data['image'],
            ),
          ),
          Container(
            width: 400,
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Text(
                  niceDate(data['time']),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: RWColors.darkBlue
                  ),
                ),
                SizedBox(height: 10.0,),
                Text(
                  data['title'],
                  style: TextStyle(
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold,
                    color: RWColors.darkBlue
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                  data['description'],
                  style: TextStyle(
                    fontSize: 16.0,
                    color: RWColors.darkBlue
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

