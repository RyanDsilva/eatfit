import 'package:eatfit/components/root.dart';
import 'package:eatfit/views/chat.dart';
import 'package:eatfit/views/exercise/doExercise.dart';
import 'package:eatfit/views/exercise/exerciseHome.dart';
import 'package:eatfit/views/food.dart';
import 'package:eatfit/views/home.dart';
import 'package:eatfit/views/settings.dart';
import 'package:eatfit/views/snap.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Root(
        child: Home(),
      );
    },
  );

  static Handler _exerciseHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Root(
        child: Exercise(),
      );
    },
  );

  static Handler _snapHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Root(
        child: Snap(),
      );
    },
  );

  static Handler _foodHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Root(
        child: Food(),
      );
    },
  );

  static Handler _chatHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Root(
        child: Chat(),
      );
    },
  );

  static Handler _doExerciseHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Root(
        child: DoExercise(),
      );
    },
  );

  static Handler _settingsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Root(
        child: Settings(),
      );
    },
  );

  static void setupRouter() {
    router.define('home', handler: _homeHandler);
    router.define('exercise', handler: _exerciseHandler);
    router.define('snap', handler: _snapHandler);
    router.define('food', handler: _foodHandler);
    router.define('chat', handler: _chatHandler);
    router.define('exercise/do', handler: _doExerciseHandler);
    router.define('settings', handler: _settingsHandler);
  }
}
