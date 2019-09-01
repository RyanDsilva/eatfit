import 'package:eatfit/router.dart';
import 'package:flutter/material.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(EatFit());
}

class EatFit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EatFit',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.yellow,
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      onGenerateRoute: FluroRouter.router.generator,
    );
  }
}
