import 'package:event_app_ikfram/screens/event_details_screen.dart';
import 'package:event_app_ikfram/screens/loading_screen.dart';
import 'package:event_app_ikfram/widgets/events/event_first_upcoming_card.dart';
import 'package:event_app_ikfram/widgets/events/event_upcoming_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import '../../utils/custom_color_scheme.dart';

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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else {
          var data = snapshot.data;
          var timestampToDateTime =
              DateTime.parse(data[0]['dateTime'].toDate().toString());
          var formattedDate =
              DateFormat('dd-MM-yyy kk:mm').format(timestampToDateTime);
          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.only(bottom: 20),
                sliver: SliverAppBar(
                  title: Text(
                    'Volgende Event',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  // backgroundColor: Theme.of(context).colorScheme.purple,
                  expandedHeight: 230,
                  actions: [
                    IconButton(
                        icon: Icon(
                          Icons.navigate_next,
                          size: 30,
                          // color: Colors.black,
                        ),
                        onPressed: () {}),
                  ],
                  flexibleSpace: EventFirstUpcomingCard(
                    name: data[0]['name'],
                    date: formattedDate,
                    teamleader: data[0]['teamleader'],
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
                        eventColor: data[index]['eventColor'],
                        dateTime: formattedDate,
                        teamleader: data[index]['teamleader'],
                        attendees: data[index]['attendees'],
                      );
                    }
                    return SizedBox(
                      height: 0,
                    );
                    // idk waarom het niet werkt, maar zonder dit kan ik niks laten zien vanuit de bovenste if statement
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
