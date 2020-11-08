import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/custom_color_scheme.dart';

class EventUpcomingCard extends StatelessWidget {
  final String name;
  final String eventColor;
  final String dateTime;
  final String teamleader;
  final List<dynamic> attendees;
  final bool isUpcoming;

  EventUpcomingCard(
      {this.name,
      this.eventColor,
      this.dateTime,
      this.teamleader,
      this.attendees,
      this.isUpcoming = false});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    Color _colorGetter(String eventColor) {
      ColorScheme theme = Theme.of(context).colorScheme;

      switch (eventColor) {
        case 'blue':
          return theme.blue;
          break;
        case 'mint':
          return theme.mint;
          break;
        case 'pink':
          return theme.pink;
          break;
        case 'purple':
          return theme.purple;
          break;
      }
    }

    if (attendees.contains(auth.currentUser.uid)) {
      return Container(
        height: isUpcoming ? 300 : 90,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.event,
                  size: 50,
                  color: _colorGetter(eventColor),
                ),
                title: Text(
                  name,
                  style: TextStyle(
                      // color: Colors.white,
                      // fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  children: [
                    Row(children: [
                      Icon(
                        Icons.date_range,
                        color: Colors.grey,
                        size: 15,
                      ),
                      Text(
                        dateTime,
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 15,
                        ),
                        Text(
                          teamleader,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      // return Card(
      //   child: SizedBox(
      //     width: 50,
      //     child: Column(
      //       children: [
      //         Text(name),
      //         Text(dateTime),
      //         Text(teamleader),
      //       ],
      //     ),
      //   ),
      // );
    }
  }
}
