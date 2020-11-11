import 'package:flutter/material.dart';

class ChatUserBubble extends StatelessWidget {
  final String user;

  ChatUserBubble({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(user),
    );
  }
}
