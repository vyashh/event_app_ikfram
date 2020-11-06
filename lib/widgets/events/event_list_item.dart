import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../providers/DB_provider.dart';

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
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done &&
              attendees.contains(auth.currentUser.uid)) {
            Map<String, dynamic> data = snapshot.data.data();
            return GestureDetector(
              onTap: () {
                print('Hi');
              },
              child: Container(
                padding: EdgeInsets.all(20),
                height: 150,
                width: double.maxFinite,
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                          name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Image.network(
                            'https://i.pinimg.com/originals/41/66/0b/41660bbaea604cf4c82cae29a631488c.jpg',
                            width: 50,
                          ),
                          Column(children: [
                            Text(dateTime == null ? "TBA" : dateTime),
                            Text(teamleader == null ? "TBA" : data['name']),
                            Text(dateTime == null ? "TBA" : dateTime),
                          ]),
                        ],
                      )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0, 15),
                      color: Colors.black.withOpacity(.1),
                      spreadRadius: -40,
                    )
                  ],
                ),
              ),
            );
          }

          return Text("loading");
        });
  }
}
