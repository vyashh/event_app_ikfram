import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetailsScreen extends StatefulWidget {
  static const routeName = '/event-details';

  final dynamic event;
  final String date;

  EventDetailsScreen({this.event, this.date});

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event['name']),
      ),
      body: Card(
        child: ListTile(
          title: Text(widget.event['name']),
          subtitle: Text(
            widget.date == null ? 'null' : widget.date,
          ),
        ),
      ),
    );
  }
}
