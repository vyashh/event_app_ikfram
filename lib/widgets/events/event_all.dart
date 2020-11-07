import 'package:event_app_ikfram/screens/event_details_screen.dart';
import 'package:event_app_ikfram/screens/loading_screen.dart';
import 'package:event_app_ikfram/widgets/events/event_upcoming_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

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
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

    return FutureBuilder(
      future: getEvents(),
      builder: (_, snapshot) {
        var data = snapshot.data;
        var timestampToDateTime =
            DateTime.parse(data[0]['dateTime'].toDate().toString());
        var formattedDate =
            DateFormat('dd-MM-yyy kk:mm').format(timestampToDateTime);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else {
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text(
                  formattedDate,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                expandedHeight: 200,
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                      ),
                      onPressed: () {}),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    data[0]['name'],
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  background: Image.network(
                    'https://i.imgur.com/P7KCEnY.png',
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.overlay,
                    color: Theme.of(context).primaryColor.withOpacity(1),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var data = snapshot.data;
                    var timestampToDateTime = DateTime.parse(
                        data[index]['dateTime'].toDate().toString());
                    var formattedDate = DateFormat('dd-MM-yyy kk:mm')
                        .format(timestampToDateTime);
                    final List<dynamic> attendees = data[index]['attendees'];

                    if (attendees.contains(auth.currentUser.uid) && index > 0) {
                      return EventUpcomingCard(
                        name: data[index]['name'],
                        dateTime: formattedDate,
                        teamleader: data[index]['teamleader'],
                        attendees: data[index]['attendees'],
                      );
                    }
                    return SizedBox(); // idk waarom het niet werkt, maar zonder dit kan ik niks laten zien vanuit de bovenste if statement
                  },
                  childCount: data.length,
                ),
              ),
            ],
          );

          // return ListView.builder(
          //   itemCount: data.length,
          //   itemBuilder: (_, index) {},
          // );
        }
      },
    );
  }
}
