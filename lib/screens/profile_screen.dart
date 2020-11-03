import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Hoi'),
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
