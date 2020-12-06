import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app_ikfram/widgets/profile/profile_hero.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/custom_color_scheme.dart';

class ProfileScreen extends StatelessWidget {
  User currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var currentUserData = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    return FutureBuilder(
      future: currentUserData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        print(currentUser.uid);
        var user = snapshot.data;

        return ListView(
          children: [
            Container(
              height: 230,
              child: Center(
                child: Text(
                  user['name'],
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              color: Theme.of(context).colorScheme.purple,
            ),
            ListTile(
              leading: Icon(Icons.vpn_key_sharp),
              title: Text('Reset wachtwoord'),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Reset e-mail'),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Uitloggen'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                context.read<AuthProvider>().signOut();
              },
            ),
          ],
        );
      },
    );
  }
}
