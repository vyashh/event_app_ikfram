import 'package:event_app_ikfram/screens/event_details_screen.dart';
import 'package:event_app_ikfram/screens/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'event_list_item.dart';

class EventAll extends StatelessWidget {
  var userDocs;

  Future getEvents() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot eventSnapshot = await firestore.collection('events').get();

    return eventSnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getEvents(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else {
          var data = snapshot.data;

          return ListView.builder(itemBuilder: (_, index) {
            var timestapToDateTime =
                DateTime.parse(data[index]['dateTime'].toDate().toString());
            var formattedDate =
                DateFormat('dd-MM-yyy kk:mm').format(timestapToDateTime);
            print(data[index]['name']);
            ListTile(
              title: Text(
                data[index]['name'],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsScreen(
                      event: snapshot.data[index],
                      dateTime: formattedDate,
                    ),
                  ),
                );
              },
            );
          });
        }
      },
    );
  }
}
