import 'package:event_app_ikfram/screens/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/custom_color_scheme.dart';

class EventUpcomingCard extends StatelessWidget {
  final dynamic event;
  final String date;

  EventUpcomingCard({this.event, this.date});

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

    if (event['attendees'].contains(auth.currentUser.uid)) {
      return Container(
        height: 90,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsScreen(
                          event: event,
                          date: date,
                        ),
                      ));
                },
                leading: Icon(
                  Icons.event,
                  size: 50,
                  color: _colorGetter(event['eventColor']),
                ),
                title: Text(
                  event['name'],
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
                        date,
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
                          event['teamleader'],
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      );
    }
  }
}
