import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        Text("Home"),
  );

  static void setupRouter() {
    router.define('/', handler: _homeHandler);
  }
}
