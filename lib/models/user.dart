import 'package:eatfit/util/calorie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'meal.dart';

class User with ChangeNotifier {
  String id;
  String name;
  String email;
  List<Meal> meals;
  int currentCalories;
  int lifestyleChoice;
  String gender;

  User(
      {this.id,
      this.name,
      this.meals,
      this.email,
      this.currentCalories,
      this.lifestyleChoice,
      this.gender});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    User u = new User(
      id: doc.documentID,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      meals: Meal.fromData(data['meals']) ?? [],
      lifestyleChoice: data['lifestyleChoice'] ?? Calorie.MALE_MAINTAIN,
      gender: data['gender'] ?? "Male",
    );
    int cal = 0;
    for (var meal in u.getMeals()) {
      cal += meal.calories;
    }
    u.setCalories(cal);
    return u;
  }

  String getName() => this.name;
  String getID() => this.id;
  String getEmail() => this.email;
  List<Meal> getMeals() => this.meals;
  int getCurrentCalories() => this.currentCalories;
  int getLifestyleChoice() => this.lifestyleChoice;
  String getGender() => this.gender;

  setName(String name) => this.name = name;
  setLifestyleChoice(int value) => this.lifestyleChoice = value;
  setGender(String gender) => this.gender = gender;

  void addMeal(Meal meal) {
    this.meals.add(meal);
    notifyListeners();
  }

  void setCalories(int cal) {
    this.currentCalories = cal;
  }

  void updateCalorieCount(int value) {
    this.currentCalories += value;
    notifyListeners();
  }
}
