import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'dashboard.dart';
import 'chat_page.dart';
import 'profile_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter widgets are initialized
  await Firebase.initializeApp(); // Initializes Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => Dashboard(),
        '/homeworkHelp': (context) => ChatPage('Homework Help'),
        '/studyBuddies': (context) => ChatPage('Study Buddies'),
        '/pantherChat': (context) => ChatPage('PantherChat'),
        '/pawTalk': (context) => ChatPage('PawTalk'),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
