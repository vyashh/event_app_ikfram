import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventUpcomingCard extends StatelessWidget {
  final String name;
  final String dateTime;
  final String teamleader;
  final List<dynamic> attendees;
  final bool isUpcoming;

  EventUpcomingCard(
      {this.name,
      this.dateTime,
      this.teamleader,
      this.attendees,
      this.isUpcoming = false});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (attendees.contains(auth.currentUser.uid)) {
      return Container(
        height: isUpcoming ? 300 : 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          // color: Theme.of(context).primaryColor,
          // elevation: 10,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Image.network(
                      'https://i.pinimg.com/originals/41/66/0b/41660bbaea604cf4c82cae29a631488c.jpg'),
                  title: Text(
                    name,
                    style: TextStyle(
                        // color: Colors.white,
                        // fontSize: 20,
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
                          style: TextStyle(),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // ButtonTheme.bar(
                //   child: ButtonBar(
                //     children: <Widget>[
                //       FlatButton(
                //         child: const Text('Edit',
                //             style: TextStyle(color: Colors.white)),
                //         onPressed: () {},
                //       ),
                //       FlatButton(
                //         child: const Text('Delete',
                //             style: TextStyle(color: Colors.white)),
                //         onPressed: () {},
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
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
