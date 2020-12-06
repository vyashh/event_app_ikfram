import 'package:event_app_ikfram/providers/auth_provider.dart';
import 'package:event_app_ikfram/screens/chat/chat_screen.dart';
import 'package:event_app_ikfram/screens/dev_page.dart';
import 'package:event_app_ikfram/screens/event_details_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'screens/chat/chats_person_screen.dart';
import './widgets/auth/auth_wrapper.dart';

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          primarySwatch: Colors.purple,
          accentColor: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthWrapper(),
        routes: {
          ChatsPerson.routeName: (ctx) => ChatsPerson(),
          EventDetailsScreen.routeName: (ctx) => EventDetailsScreen(),
          DevPage.routeName: (ctx) => DevPage(),
        },
      ),
    );
  }
}
