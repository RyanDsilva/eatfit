import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  String name;
  int calories;
  DateTime time;

  Meal({this.name, this.calories, this.time});

  static List<Meal> fromData(List meals) {
    List<Meal> finalMeals = [];
    for (var data in meals) {
      Meal m = Meal(
        name: data['name'] ?? '',
        calories: data['calories'] ?? 0,
        time:
            DateTime.fromMillisecondsSinceEpoch(data['time'].seconds * 1000) ??
                '',
      );
      finalMeals.add(m);
    }
    return finalMeals;
  }

  factory Meal.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data ?? {};
    return Meal(
      name: data['name'] ?? '',
      calories: data['calories'] ?? 0,
      time: DateTime.fromMillisecondsSinceEpoch(data['time'].seconds * 1000) ??
          '',
    );
  }

  String getMeal() => this.name;
  int getCalorieValue() => this.calories;
  DateTime getTimeOfConsumption() => this.time;

  setMeal(String name) => this.name = name;
  setCalorieValue(int calories) => this.calories = calories;
  setTimeOfConsumption(DateTime date) => this.time = date;
}
