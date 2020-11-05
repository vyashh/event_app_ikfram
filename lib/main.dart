import 'package:event_app_ikfram/providers/auth_provider.dart';
import 'package:event_app_ikfram/screens/home_screen.dart';
import 'package:event_app_ikfram/widgets/auth/auth_wrapper.dart';
import 'package:event_app_ikfram/widgets/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(
          create: (_) => AuthProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthProvider>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Epp',
        theme: ThemeData(
            fontFamily: 'Roboto',
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            backgroundColor: Colors.white10),
        home: AuthWrapper(),
      ),
    );
  }
}
