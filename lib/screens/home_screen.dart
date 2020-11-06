import 'package:flutter/material.dart';

import '../widgets/events/event_first_upcoming.dart';
import '../widgets/events/event_all.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: SizedBox(
            height: 300,
            child: EventFirstUpcoming(),
          ),
        ),
        EventAll()
      ],
    );
  }
}
