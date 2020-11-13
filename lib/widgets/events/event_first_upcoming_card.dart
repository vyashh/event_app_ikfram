import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../screens/event_details_screen.dart';

class EventFirstUpcomingCard extends StatefulWidget {
  final dynamic event;
  final String date;

  EventFirstUpcomingCard({this.event, this.date});

  @override
  _EventFirstUpcomingCardState createState() => _EventFirstUpcomingCardState();
}

class _EventFirstUpcomingCardState extends State<EventFirstUpcomingCard> {
  String teamLeaderName;

  Future<String> _getTeamleader(String teamleaderId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(widget.event['teamleader'])
        .get()
        .then(
          (value) => (teamLeaderName = value['name']),
        );
  }

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background.jpg',
            ),
            fit: BoxFit.cover,
            // scale: 1,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(.6), BlendMode.overlay),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsScreen(
                      event: widget.event,
                      date: widget.date,
                    ),
                  ));
            },
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event['name'],
                  style: TextStyle(
                      color: Colors.white.withOpacity(.9),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.grey,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.date,
                      style: TextStyle(
                          fontSize: 12, color: Colors.white.withOpacity(.8)),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.event['teamleader'],
                      style: TextStyle(
                          fontSize: 12, color: Colors.white.withOpacity(.8)),
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(left: 80),
              child: Transform.scale(
                scale: .9,
                child: Image.asset(
                  'assets/images/home-avatar.png',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
