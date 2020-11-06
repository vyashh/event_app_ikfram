import 'package:event_app_ikfram/widgets/dev/dev_add_event.dart';
import 'package:flutter/material.dart';

class DevPage extends StatefulWidget {
  static const routeName = '/dev-page';

  @override
  _DevPageState createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.event)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Dev Page'),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: TabBarView(
            children: [
              AddEvent(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
