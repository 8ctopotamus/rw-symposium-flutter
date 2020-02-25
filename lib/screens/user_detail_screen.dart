import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rw_symposium_flutter/components/layout.dart';
import 'package:rw_symposium_flutter/components/avatar.dart';
import 'package:rw_symposium_flutter/constants.dart';

class UserDetailScreen extends StatelessWidget {
  final data;

  UserDetailScreen({@required this.data});

  void launchURL(url) async {
    if (!url.contains('//')) {
      url = 'https://$url';
    }
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext content) {
    final avatar = data['avatar'] == false ? null : data['avatar'];
    return Layout(
      title: data['username'],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: 'user-${data['email']}',
            child: AppAvatar(
              name: data['username'],
              image: avatar,
              radius: 100.0,
              fontSize: 80.0,
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data['username'],
                        textAlign: TextAlign.left,
                        style: headingStyle,
                      ),
                      if (data['designation'] != null && data['designation'] != '')
                        Text(
                          data['designation'],
                          textAlign: TextAlign.left,
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.stars),
                    Text(data['points'].toString())
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.white,
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (data['phone'] != null && data['phone'] != '')
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.phone),
                      tooltip: data['phone'],
                      onPressed: () {
                        launchURL("tel://${data['phone']}");
                      },
                    ),
                    Text('Call'),
                  ],
                ),
              if (data['email'] != null && data['email'] != '')
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.email),
                      tooltip: data['email'],
                      onPressed: () {
                        launchURL("mailto://${data['email']}");
                      },
                    ),
                    Text('Email'),
                  ],
                ),
              if (data['website'] != null && data['website'] != '')
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.web),
                      tooltip: data['website'],
                      onPressed: () {
                        launchURL(data['website']);
                      },
                    ),
                    Text('Website'),
                  ],
                ),
            ],
          ),
          Divider(
            color: Colors.white,
            height: 40.0,
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text(
              data['bio'],
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
