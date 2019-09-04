import 'package:eatfit/components/root.dart';
import 'package:eatfit/views/auth.dart';
import 'package:eatfit/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  Landing({Key key}) : super(key: key);

  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  FirebaseUser user;

  Future<FirebaseUser> _getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser();
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
