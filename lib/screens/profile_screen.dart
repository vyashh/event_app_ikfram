import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(currentUser.email),
        RaisedButton(
          onPressed: () {
            context.read<AuthProvider>().signOut();
          },
          child: Text('Signout'),
        )
      ],
    );
  }
}
