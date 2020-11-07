import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEvent extends StatelessWidget {
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void _addEvent() {
    var i = 0;
    while (i < 5) {
      i++;
      FirebaseFirestore.instance.collection("events").add({
        "name": getRandomString(10),
        "attendees": ['prdvRniEhtdJgL9C8pkSgs7irh13'],
        "dateTime": DateTime.utc(2021, DateTime.june, 6),
        "teamleader": "prdvRniEhtdJgL9C8pkSgs7irh13"
      }).then((response) {
        print(response.hashCode);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Event Tool'),
        RaisedButton(onPressed: _addEvent, child: Text('Add Events'))
      ],
    );
  }
}
