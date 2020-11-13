import 'package:event_app_ikfram/widgets/chat/chat_messages.dart';
import 'package:event_app_ikfram/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-user';
  final String currentUser;
  final String otherPerson;

  ChatScreen({
    @required this.currentUser,
    @required this.otherPerson,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
                currentUser: widget.currentUser,
                otherPerson: widget.otherPerson,
              ),
            ),
            NewMessage(
              otherUser: widget.otherPerson,
            ),
          ],
        ),
      ),
    );
  }
}

// ChatMessages(currentUser: currentUser,otherPerson: otherPerson,),
