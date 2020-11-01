import 'package:event_app_ikfram/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('Hoi'),
          RaisedButton(
            onPressed: () {
              context.read<AuthProvider>().signOut();
            },
            child: Text('Signout'),
          )
        ],
      ),
    );
  }
}
