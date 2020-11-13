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
            .doc(currentUser)
            .collection('chats')
            .doc(otherPerson)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          } else {
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
          }
        });
  }
}
