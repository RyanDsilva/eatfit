import 'package:circle_wave_progress/circle_wave_progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatfit/components/customLoader.dart';
import 'package:eatfit/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String id;

  const Home({Key key, this.id}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Firestore db = Firestore.instance;
  bool _isLoading = true;
  User user;

  Future<User> _getCurrentUserFromFirestore(String id) async {
    return User.fromFirestore(await db.collection('users').document(id).get());
  }

  @override
  void initState() {
    super.initState();
    this._getCurrentUserFromFirestore(this.widget.id).then((_user) {
      setState(() {
        this.user = _user;
        this._isLoading = false;
      });
    });
  }

  double getPercentage() {
    return (this.user.currentCalories / this.user.lifestyleChoice) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return !this._isLoading
        ? Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 6, 20),
                          child: Text(
                            "Hello",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 20),
                          child: Text(
                            this.user.name,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: new BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: new BorderRadius.only(
                        bottomLeft: const Radius.circular(50.0),
                        bottomRight: const Radius.circular(50.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Today's Calorie Intake\n" +
                          this.user.currentCalories.toString() +
                          " / " +
                          this.user.lifestyleChoice.toString(),
                      style: TextStyle(
                        letterSpacing: 0.5,
                        //fontWeight: FontWeight.w100,
                        color: Theme.of(context).primaryColor,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleWaveProgress(
                      backgroundColor: Colors.transparent,
                      borderColor: Theme.of(context).primaryColor,
                      borderWidth: 7.0,
                      waveColor: getPercentage() <= 100
                          ? Theme.of(context).accentColor
                          : Theme.of(context).errorColor,
                      progress: getPercentage() <= 100 ? getPercentage() : 100,
                      size: 275.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                    child: Text(
                      "© Ryan, Niharika & Katoushka 2019-20",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(child: CustomLoader());
  }
}
