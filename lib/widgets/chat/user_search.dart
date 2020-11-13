import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app_ikfram/screens/chat/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSearch extends SearchDelegate<String> {
  Future getUsers() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot userSnapshot = await firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query.toUpperCase())
        .get();

    return userSnapshot.docs;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text('Loading'),
          );
        }

        List<dynamic> userList = snapshot.data.toList();

        return ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(userList[index]['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(
                              currentUser:
                                  FirebaseAuth.instance.currentUser.uid,
                              otherPerson: userList[index]['uid'],
                            )),
                  );
                });
          },
        );
      },
    );
  }
}
