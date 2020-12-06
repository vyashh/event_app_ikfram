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
    var firestore = FirebaseFirestore.instance;

    Future<void> _checkExistsChat() async {
      var userChat = firestore
          .collection('chat')
          .doc(currentUser)
          .collection('chats')
          .doc(otherPerson);

      var userChatDoc = await userChat.get();
      var otherPersonDoc =
          await firestore.collection('users').doc(otherPerson).get();
      print(otherPersonDoc['name']);

      if (userChatDoc.exists) {
        //print(otherPersonDoc['name']);
        return;
      } else {
        print('made chat');
        await firestore
            .collection('chat')
            .doc(currentUser)
            .collection('chats')
            .doc(otherPerson)
            .set(
          {'uid': otherPerson, 'messages': [], 'name': otherPersonDoc['name']},
        );
      }
    }

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .doc(currentUser)
            .collection('chats')
            .doc(otherPerson)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.data.exists) {
            return Center(
              child: Text('No messages'),
            );
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
