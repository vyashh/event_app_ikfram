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
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(bottom: 20),
          sliver: SliverAppBar(
            title: Text(
              'Volgende Event',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).colorScheme.purple,
            expandedHeight: 230,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.navigate_next,
                  size: 30,
                  // color: Colors.black,
                ),
                onPressed: () {},
              )
            ],
            flexibleSpace: ProfileHero(),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Center(
              child: Column(
                children: [
                  Text('Reset Password'),
                  Text('Item'),
                  Text('Item'),
                  Text('Item'),
                ],
              ),
            )
          ]),
        ),
      ],
    );
  }
}
