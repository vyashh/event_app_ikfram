import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetailsScreen extends StatelessWidget {
  static const routeName = '/event-details';

  final dynamic event;
  final String date;

  EventDetailsScreen({this.event, this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event['name']),
      ),
      body: Card(
        child: ListTile(
          title: Text(event['name']),
          subtitle: Text(
            date == null ? 'null' : date,
          ),
        ),
      ),
    );
  }
}
