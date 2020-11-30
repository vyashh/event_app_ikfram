import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/custom_color_scheme.dart';

class NewMessage extends StatefulWidget {
  final String otherPerson;

  NewMessage({this.otherPerson});

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    // FocusScope.of(context).unfocus();
    final currentUser = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    DocumentReference chatRef = FirebaseFirestore.instance
        .collection('chat')
        .doc(currentUser.uid)
        .collection('chats')
        .doc(widget.otherPerson);

    print(chatRef);

    chatRef.update({
      'messages': FieldValue.arrayUnion([
        {
          'createdAt': 'Now',
          'sender': userData['name'],
          'senderId': currentUser.uid,
          'text': _enteredMessage,
        }
      ])
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.blue),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      // margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(6),
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Send a message...',
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              color: Theme.of(context).primaryColor,
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage),
        ],
      ),
    );
    ;
  }
}
