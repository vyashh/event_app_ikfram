import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app_ikfram/widgets/chat/user_search.dart';
import 'package:flutter/material.dart';

import '../loading_screen.dart';
import '../../widgets/chat/chat_users.dart';

class ChatsPerson extends StatefulWidget {
  static const routeName = '/chat';
  @override
  _ChatsPersonState createState() => _ChatsPersonState();
}

class _ChatsPersonState extends State<ChatsPerson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
              // color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              showSearch(context: context, delegate: UserSearch());
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ChatUsers(),
          ],
        ),
      ),
    );
  }
}
