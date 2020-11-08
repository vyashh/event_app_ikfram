import 'package:event_app_ikfram/screens/dev_page.dart';
import 'package:event_app_ikfram/screens/test_screen.dart';
import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';
import '../screens/home_screen.dart';
import '../screens/previous_events_screen.dart';

import '../screens/chat_screen.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  String _title = 'Events';

  List<Widget> _widgetOptions = [
    HomeScreen(),
    PreviousEvents(),
    ProfileScreen(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          {
            _title = 'Events';
          }
          break;
        case 1:
          {
            _title = 'Vorige events';
          }
          break;
        case 2:
          {
            _title = 'Profiel';
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.chat_rounded,
              color: Colors.black,
              // color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(ChatScreen.routeName);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(DevPage.routeName);
              // Navigator.of(context).pushNamed(TestScreen.routeName);
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex:
            _selectedIndex, // set current index naar selected index. Deze gebruik je om van pagina te wisselen.
        onTap: _onItemTap,
      ),
    );
  }
}
