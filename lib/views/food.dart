import 'package:eatfit/components/customCard.dart';
import 'package:eatfit/components/customLoader.dart';
import 'package:eatfit/models/user.dart';
import 'package:eatfit/util/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Food extends StatefulWidget {
  const Food({Key key}) : super(key: key);

  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  bool isLoading = true;
  DatabaseService db = DatabaseService();
  User user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((fbuser) {
      db.getUser(fbuser.uid).then((user) {
        setState(() {
          this.user = user;
          this.isLoading = false;
        });
      });
    });
  }

  final recMeals = [
    'Eggs and Brown Bread',
    'Salad & Vegetable Stir Fry',
    'Soup and Fruits',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: this.isLoading
          ? Center(
              child: CustomLoader(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCard(
                  bgColor: Theme.of(context).primaryColor,
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Meal Log",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).accentColor,
                        thickness: 2,
                      ),
                      ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              this.user.getMeals()[index].getMeal(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            subtitle: Text(
                              new DateFormat.yMMMEd('en_US')
                                  .add_jms()
                                  .format(this
                                      .user
                                      .getMeals()[index]
                                      .getTimeOfConsumption())
                                  .toString(),
                              style: TextStyle(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            trailing: Text(
                              this
                                  .user
                                  .getMeals()[index]
                                  .getCalorieValue()
                                  .toString(),
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        itemCount: this.user.getMeals().length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Theme.of(context).accentColor,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                CustomCard(
                  bgColor: Theme.of(context).primaryColor,
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Recommended Meals",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).accentColor,
                        thickness: 2,
                      ),
                      ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              this.recMeals[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          );
                        },
                        itemCount: 3,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Theme.of(context).accentColor,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
    );
  }
}
