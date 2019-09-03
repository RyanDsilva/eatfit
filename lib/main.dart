import 'package:eatfit/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(EatFit());
}

class EatFit extends StatelessWidget {
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
        initialRoute: 'home',
        onGenerateRoute: FluroRouter.router.generator,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
