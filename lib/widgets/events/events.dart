import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'event_list_item.dart';

class Events extends StatelessWidget {
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
        return ListView.builder(
          reverse: true,
          itemCount: eventDocs.length,
          itemBuilder: (ctx, index) =>
              EventListItem(name: eventDocs[index]['name']),
        );
      },
    );
  }
}
