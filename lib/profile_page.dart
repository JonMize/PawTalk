import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String firstName = '';
  String lastName = '';
  String role = '';
  String dob = '';

  Future<void> loadProfile() async {
    final user = _auth.currentUser!;
    final userData = await _firestore.collection('users').doc(user.uid).get();

    setState(() {
      firstName = userData['firstName'];
      lastName = userData['lastName'];
      role = userData['role'];
      dob = userData['dob'] ?? '';
    });
  }

  Future<void> updateProfile() async {
    final user = _auth.currentUser!;
    await _firestore.collection('users').doc(user.uid).update({
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'dob': dob,
    });
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: firstName,
              decoration: InputDecoration(labelText: 'First Name'),
              onChanged: (value) => firstName = value,
            ),
            TextFormField(
              initialValue: lastName,
              decoration: InputDecoration(labelText: 'Last Name'),
              onChanged: (value) => lastName = value,
            ),
            TextFormField(
              initialValue: role,
              decoration: InputDecoration(labelText: 'Role'),
              onChanged: (value) => role = value,
            ),
            TextFormField(
              initialValue: dob,
              decoration: InputDecoration(labelText: 'Date of Birth'),
              onChanged: (value) => dob = value,
            ),
            ElevatedButton(
              onPressed: updateProfile,
              child: Text('Save Changes'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
