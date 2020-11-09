import 'package:event_app_ikfram/widgets/profile/profile_hero.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/custom_color_scheme.dart';

class ProfileScreen extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: <Widget>[
    //     Text(currentUser.email),
    //     RaisedButton(
    //       onPressed: () {
    //         context.read<AuthProvider>().signOut();
    //       },
    //       child: Text('Signout'),
    //     )
    //   ],
    // );
    return ListView(
      children: [
        Container(
          height: 230,
          color: Theme.of(context).colorScheme.purple,
          
        ),
        ListTile(
          leading: Icon(Icons.vpn_key_sharp),
          title: Text('Reset wachtwoord'),
          trailing: Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('Reset E-mail'),
          trailing: Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
