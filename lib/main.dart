import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatfit/models/user.dart';
import 'package:eatfit/router.dart';
import 'package:eatfit/util/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(EatFit());
}

class EatFit extends StatelessWidget {
  final db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
      ],
      child: MaterialApp(
        title: 'EatFit',
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          accentColor: Colors.yellow,
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: '/',
        onGenerateRoute: FluroRouter.router.generator,
      ),
    );
  }
}
