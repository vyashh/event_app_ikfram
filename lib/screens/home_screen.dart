import '../widgets/events/event_all.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            transform: Matrix4.translationValues(0.0, 50.0, 20.0),
            padding: EdgeInsets.only(left: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              'Events',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          EventAll(),
        ],
      ),
    );
  }
}
