// import 'dart:io' show Platform;
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DateTime convertStamp(Timestamp _stamp) {
  if (_stamp != null) {
    return Timestamp(_stamp.seconds, _stamp.nanoseconds).toDate();
    /*
    if (Platform.isIOS) {
      return _stamp.toDate();
    } else {
      return Timestamp(_stamp.seconds, _stamp.nanoseconds).toDate();
    }
    */
  } else {
    return null;
  }
}

String niceDate(Timestamp timestamp) {
  var dateTime = convertStamp(timestamp);
  String formattedDate = DateFormat('MMMM dd, yyyy – kk:mm').format(dateTime);
  return formattedDate;
}