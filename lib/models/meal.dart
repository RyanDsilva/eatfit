import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  String name;
  int calories;
  DateTime time;

  Meal({this.name, this.calories, this.time});

  factory Meal.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data ?? {};
    return Meal(
      name: data['name'] ?? '',
      calories: data['calories'] ?? 0,
      time: data['time'] ?? '',
    );
  }

  getMeal() => this.name;
  getCalorieValue() => this.calories;
  getTimeOfConsumption() => this.time;

  setMeal(String name) => this.name = name;
  setCalorieValue(int calories) => this.calories = calories;
  setTimeOfConsumption(DateTime date) => this.time = date;
}
