import 'package:eatfit/models/exercise.dart';
import 'package:eatfit/util/exerciseList.dart';
import 'package:flutter/material.dart';

class ExerciseHome extends StatelessWidget {
  const ExerciseHome({Key key}) : super(key: key);

  Widget cards(context, Exercise exercise) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'exercise/' + exercise.getID());
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6.0,
            ),
          ],
          color: Colors.grey.shade100,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                exercise.getImage(),
                height: 80,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                exercise.getName(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 4),
                color: Color(0xFF92DCE5),
                child: Text(
                  "x " + exercise.getReps(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Exercise> exercises = exerciseList;
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Theme.of(context).primaryColor,
            ),
            width: double.infinity,
          ),
          Container(
            margin: EdgeInsets.only(left: 90, bottom: 20),
            width: 299,
            height: 279,
            decoration: BoxDecoration(
              color: Colors.blueAccent.shade200,
              // color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(160),
                bottomLeft: Radius.circular(290),
                bottomRight: Radius.circular(160),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Today's Exercise",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Routine",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(26.0),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: <Widget>[
                    cards(
                      context,
                      exercises[0],
                    ),
                    cards(
                      context,
                      exercises[1],
                    ),
                    cards(
                      context,
                      exercises[2],
                    ),
                    cards(
                      context,
                      exercises[3],
                    ),
                    cards(
                      context,
                      exercises[4],
                    ),
                    cards(
                      context,
                      exercises[5],
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
                  child: RaisedButton(
                    onPressed: () => Navigator.of(context).pushNamed('maps'),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Go For A Run',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
