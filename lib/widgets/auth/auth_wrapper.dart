import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../screens/auth_screen.dart';
import '../../screens/home_screen.dart';
import '../navbar.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<User>();

    if (currentUser != null) {
      return NavBar();
    }

    return AuthScreen();
  }
}
