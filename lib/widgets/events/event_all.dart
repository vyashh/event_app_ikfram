import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../utils/custom_color_scheme.dart';

import 'package:event_app_ikfram/screens/event_details_screen.dart';
import 'package:event_app_ikfram/screens/loading_screen.dart';
import 'package:event_app_ikfram/widgets/events/event_first_upcoming_card.dart';
import 'package:event_app_ikfram/widgets/events/event_upcoming_card.dart';

class EventAll extends StatelessWidget {
  var userDocs;
  ScrollController _scrollController;

  Future getEvents(String currentUser) async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot eventSnapshot = await firestore
        .collection('events')
        .orderBy('dateTime')
        .where('attendees', arrayContains: currentUser)
        .get();
    return eventSnapshot.docs;
  }

  Future<void> _refreshEvents() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    getEvents(auth.currentUser.uid);
  }

  _toDetailScreen({BuildContext context, dynamic event, String date}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventDetailsScreen(
            event: event,
            date: date,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

    return FutureBuilder(
      future: getEvents(auth.currentUser.uid.toString()),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else {
          if (snapshot.data.length <= 0) {
            return RefreshIndicator(
                onRefresh: _refreshEvents,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/no_data.png',
                        scale: 7,
                        fit: BoxFit.contain,
                      ),
                      Text('Geen rooster beschikbaar.')
                    ],
                  ),
                ));
          }

          var data = snapshot.data;
          var timestampToDateTime =
              DateTime.parse(data[0]['dateTime'].toDate().toString());
          var formattedDate =
              DateFormat('dd-MM-yyy | kk:mm').format(timestampToDateTime);

          return RefreshIndicator(
            onRefresh: _refreshEvents,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 20),
                  sliver: SliverAppBar(
                    title: Text(
                      'Volgende Event',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.purple,
                    expandedHeight: 230,
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.navigate_next,
                          size: 30,
                          // color: Colors.black,
                        ),
                        onPressed: () {
                          _toDetailScreen(
                              context: context,
                              date: formattedDate,
                              event: data[0]);
                        },
                      ),
                    ],
                    flexibleSpace: EventFirstUpcomingCard(
                      event: data[0],
                      date: formattedDate,
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

                      if (attendees.contains(auth.currentUser.uid) &&
                          index > 0) {
                        return EventUpcomingCard(
                          event: data[index],
                          date: formattedDate,
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
            ),
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
