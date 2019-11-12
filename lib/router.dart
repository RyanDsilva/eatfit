import 'package:eatfit/components/root.dart';
import 'package:eatfit/views/auth.dart';
import 'package:eatfit/views/exercise/doExercise.dart';
import 'package:eatfit/views/exercise/exerciseHome.dart';
import 'package:eatfit/views/food.dart';
import 'package:eatfit/views/home.dart';
import 'package:eatfit/views/landing.dart';
import 'package:eatfit/views/maps.dart';
import 'package:eatfit/views/snap.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Landing();
    },
  );

  static Handler _authHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Auth();
    },
  );

  static Handler _homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Root(
        child: Home(
          id: params["id"][0],
        ),
      );
    },
  );

  static Handler _exerciseHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Root(
        child: ExerciseHome(),
      );
    },
  );

  static Handler _snapHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Root(
        child: Snap(
          value: int.parse(params["value"][0]),
        ),
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

  static Handler _doExerciseHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Root(
        child: DoExercise(
          id: params["id"][0],
        ),
      );
    },
  );

  static Handler _mapsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Maps();
    },
  );

  static void setupRouter() {
    router.define(
      'home',
      handler: _rootHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'auth',
      handler: _authHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'dashboard/:id',
      handler: _homeHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'exercise',
      handler: _exerciseHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'snap/:value',
      handler: _snapHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'food',
      handler: _foodHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'exercise/:id',
      handler: _doExerciseHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'maps',
      handler: _mapsHandler,
      transitionType: TransitionType.cupertino,
    );
  }
}
