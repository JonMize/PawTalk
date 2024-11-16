import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message Boards')),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('HomeworkHelp'),
            onTap: () => Navigator.pushNamed(context, '/homeworkHelp'),
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('StudyBuddies'),
            onTap: () => Navigator.pushNamed(context, '/studyBuddies'),
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('PantherChat'),
            onTap: () => Navigator.pushNamed(context, '/pantherChat'),
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('PawTalk'),
            onTap: () => Navigator.pushNamed(context, '/pawTalk'),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/profile'),
            child: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
