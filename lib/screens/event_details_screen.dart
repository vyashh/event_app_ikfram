import 'package:event_app_ikfram/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetailsScreen extends StatelessWidget {
  static const routeName = '/event-details';
  final String image = "assets/images/background-normal.jpg";

  final dynamic event;
  final String date;

  EventDetailsScreen({this.event, this.date});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(event['name']),
    //     backgroundColor: ColorProvider.colorGetter(
    //         eventColor: event['eventColor'], ctx: context),
    //   ),
    //   body: Card(
    //     child: ListTile(
    //       title: Text(event['name']),
    //       subtitle: Text(
    //         date == null ? 'null' : date,
    //       ),
    //     ),
    //   ),
    // );

    var eventColor = ColorProvider.colorGetter(
        eventColor: event['eventColor'], ctx: context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: eventColor),
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black26),
            // height: 230,
            child: Image.asset(image, fit: BoxFit.cover),
            color: ColorProvider.colorGetter(
                eventColor: event['eventColor'], ctx: context),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    event['name'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Row(
                //   children: <Widget>[
                //     const SizedBox(width: 16.0),
                //     Container(
                //       padding: const EdgeInsets.symmetric(
                //         vertical: 8.0,
                //         horizontal: 16.0,
                //       ),
                //       decoration: BoxDecoration(
                //           color: Colors.grey,
                //           borderRadius: BorderRadius.circular(20.0)),
                //       child: Text(
                //         "8.4/85 reviews",
                //         style: TextStyle(color: Colors.white, fontSize: 13.0),
                //       ),
                //     ),
                //     Spacer(),
                //     IconButton(
                //       color: Colors.white,
                //       icon: Icon(Icons.favorite_border),
                //       onPressed: () {},
                //     )
                //   ],
                // ),
                Container(
                  padding: const EdgeInsets.all(32.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: eventColor,
                          // textColor: Colors.white,
                          child: Text(
                            "View on Maps",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 32.0,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        "Description".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi iusto eius ex dolorum velit! Atque, veniam! Atque incidunt laudantium eveniet sint quod harum facere numquam molestias?",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi iusto eius ex dolorum velit! Atque, veniam! Atque incidunt laudantium eveniet sint quod harum facere numquam molestias?",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
