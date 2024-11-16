import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String role = '';
  bool isSignUp = false;

  Future<void> authenticate() async {
    try {
      if (isSignUp) {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _firestore.collection('users').doc(user.user!.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'role': role,
          'dateCreated': DateTime.now().toIso8601String(),
        });
      } else {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isSignUp ? 'Sign Up' : 'Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (isSignUp)
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                onChanged: (value) => firstName = value,
              ),
            if (isSignUp)
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                onChanged: (value) => lastName = value,
              ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) => email = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) => password = value,
            ),
            if (isSignUp)
              TextFormField(
                decoration: InputDecoration(labelText: 'Role'),
                onChanged: (value) => role = value,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: authenticate,
              child: Text(isSignUp ? 'Sign Up' : 'Login'),
            ),
            TextButton(
              onPressed: () => setState(() => isSignUp = !isSignUp),
              child:
                  Text(isSignUp ? 'Already have an account? Login' : 'Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
