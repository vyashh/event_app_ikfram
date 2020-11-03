import 'package:flutter/material.dart';

class EventListItem extends StatelessWidget {
  final String name;

  EventListItem({this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 220,
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        child: Text(
          name,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
