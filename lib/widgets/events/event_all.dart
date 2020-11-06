import 'package:event_app_ikfram/screens/event_details_screen.dart';
import 'package:event_app_ikfram/screens/loading_screen.dart';
import 'package:event_app_ikfram/widgets/events/event_upcoming_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'event_list_item.dart';

class EventAll extends StatelessWidget {
  var userDocs;
  ScrollController _scrollController;

  Future getEvents() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot eventSnapshot =
        await firestore.collection('events').orderBy('dateTime').get();

    return eventSnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return FutureBuilder(
      future: getEvents(),
      builder: (_, snapshot) {
        var data = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              var data = snapshot.data;
              var timestampToDateTime =
                  DateTime.parse(data[index]['dateTime'].toDate().toString());
              var formattedDate =
                  DateFormat('dd-MM-yyy kk:mm').format(timestampToDateTime);
              final List<dynamic> attendees = data[index]['attendees'];

              if (index == 0) {
                return EventUpcomingCard(
                  name: data[index]['name'],
                  dateTime: formattedDate,
                  teamleader: data[index]['teamleader'],
                  attendees: data[index]['attendees'],
                  isUpcoming: true,
                );
              } else {
                if (attendees.contains(auth.currentUser.uid)) {
                  return EventUpcomingCard(
                    name: data[index]['name'],
                    dateTime: formattedDate,
                    teamleader: data[index]['teamleader'],
                    attendees: data[index]['attendees'],
                  );
                }
              }
              return SizedBox(); // idk waarom het niet werkt, maar zonder dit kan ik niks laten zien vanuit de bovenste if statement
            },
          );
        }
      },
    );
  }
}
