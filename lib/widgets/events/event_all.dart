import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'event_list_item.dart';

class EventAll extends StatelessWidget {
  var userDocs;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('events').snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final eventDocs = chatSnapshot.data.documents;
        print(eventDocs[0]['dateTime']);
        return SizedBox(
          height: 175,
          child: ListView.builder(
            itemCount: eventDocs.length,
            itemBuilder: (ctx, index) => EventListItem(
              name: eventDocs[index]['name'],
              // dateTime: eventDocs[index]['dateTime'],
              teamleader: eventDocs[index]['teamleader'],
              attendees: eventDocs[index]['attendees'],
            ),
          ),
        );
      },
    );
  }
}
