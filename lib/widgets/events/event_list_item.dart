import 'package:cloud_firestore/cloud_firestore.dart';
import '../../screens/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventListItem extends StatelessWidget {
  final String name;
  final DateTime dateTime;
  final String teamleader;
  final List<dynamic> attendees;

  EventListItem({this.name, this.dateTime, this.teamleader, this.attendees});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(teamleader).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            LoadingScreen();
          }

          if (snapshot.connectionState == ConnectionState.done &&
              attendees.contains(auth.currentUser.uid)) {
            Map<String, dynamic> data = snapshot.data.data();
            return null;
          }

          return LoadingScreen();
        });
  }
}

// Text(dateTime == null ? "TBA" : dateTime),
//                           Text(teamleader == null ? "TBA" : data['name']),
//                           Text(dateTime == null ? "TBA" : dateTime),
