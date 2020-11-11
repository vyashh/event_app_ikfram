import 'package:event_app_ikfram/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatUsers extends StatelessWidget {
  User currentUser = FirebaseAuth.instance.currentUser;
  var firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .doc(currentUser.uid)
            .collection('chats')
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // print(chatSnapshot.data.documents.length);
          return ListView.builder(
            reverse: true,
            itemCount: chatSnapshot.data.documents.length,
            itemBuilder: (ctx, index) {
              DocumentSnapshot chat = chatSnapshot.data.documents[index];

              return ListTile(
                leading: Icon(Icons.person),
                title: Text(chat['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
              );
            },
          );
        });

    ;
  }
}
