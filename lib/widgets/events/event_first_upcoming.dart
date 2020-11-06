import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app_ikfram/screens/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../screens/loading_screen.dart';

class EventFirstUpcoming extends StatelessWidget {
  Future getEvents() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot eventSnapshot =
        await firestore.collection('events').orderBy('dateTime').get();

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
          var timestapToDateTime =
              DateTime.parse(data[0]['dateTime'].toDate().toString());
          var formattedDate =
              DateFormat('dd-MM-yyy kk:mm').format(timestapToDateTime);

          return ListView(
            children: [
              ListTile(
                title: Text(
                  data[0]['name'],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailsScreen(
                        event: snapshot.data[0],
                        dateTime: formattedDate,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
