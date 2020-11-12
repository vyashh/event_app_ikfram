import 'package:event_app_ikfram/widgets/chat/chat_messages.dart';
import 'package:event_app_ikfram/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String currentUser;
  final String otherPerson;

  ChatScreen({
    @required this.currentUser,
    @required this.otherPerson,
  });

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
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ChatMessages(
                currentUser: currentUser,
                otherPerson: otherPerson,
              ),
            ),
            NewMessage(
              otherUser: otherPerson,
            ),
          ],
        ),
      ),
    );
  }
}

// ChatMessages(currentUser: currentUser,otherPerson: otherPerson,),
