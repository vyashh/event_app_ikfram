import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatMessages extends StatelessWidget {
  // uid voor beide
  final String currentUser;
  final String otherPerson;

  ChatMessages({this.currentUser, this.otherPerson});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .doc('iqz0dLPspNMD2qCDhqz8aWtGQtV2')
            .collection('chats')
            .doc('8QKb2l7SAMVt8Yo49oT2')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          }
          var messages = snapshot.data['messages'];
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(messages[index]['text']),
                subtitle: Text(messages[index]['sender']),
              );
            },
          );
        });
  }
}
