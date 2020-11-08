import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventFirstUpcomingCard extends StatelessWidget {
  final String name;
  final String date;
  final String teamleader;
  String teamLeaderName;

  EventFirstUpcomingCard({this.name, this.date, this.teamleader});

  Future<String> _getTeamleader(String teamleaderId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(teamleader)
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
          padding: EdgeInsets.only(top: 100),
          child: ListTile(
            leading: Container(
              margin: EdgeInsets.only(left: 30),
              child: Transform.scale(
                scale: 3,
                child: Image.asset(
                  'assets/images/home-avatar.png',
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(left: 80),
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(left: 80, top: 10),
              child: Column(
                children: [
                  Row(
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
                        date,
                        style: TextStyle(
                            fontSize: 15, color: Colors.white.withOpacity(.8)),
                      ),
                    ],
                  ),
                  Row(
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
                        'Bobby Brown',
                        style: TextStyle(
                            fontSize: 15, color: Colors.white.withOpacity(.8)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
