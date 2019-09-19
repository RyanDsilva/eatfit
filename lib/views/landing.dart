import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatfit/components/root.dart';
import 'package:eatfit/models/user.dart';
import 'package:eatfit/views/auth.dart';
import 'package:eatfit/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  Landing({Key key}) : super(key: key);

  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  User user;
  final Firestore db = Firestore.instance;

  Future<FirebaseUser> _getCurrentUserFromAuth() async {
    return await FirebaseAuth.instance.currentUser();
  }

  Future<User> _getCurrentUser() async {
    FirebaseUser _fbUser = await _getCurrentUserFromAuth();
    if (_fbUser != null) {
      return User.fromFirestore(
          await db.collection('users').document(_fbUser.uid).get());
    }
    return null;
  }

  Widget _renderScreen() {
    _getCurrentUser().then((currentUser) {
      setState(() {
        this.user = currentUser;
      });
    });

    if (this.user != null) {
      return Root(
        child: Home(
          user: this.user,
        ),
      );
    } else {
      return Auth();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _renderScreen(),
    );
  }
}
