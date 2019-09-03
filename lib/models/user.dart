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
    return User(
      id: doc.documentID,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      currentCalories: data['currentCalories'] ?? 0,
      meals: data['meals'].map((meal) => Meal.fromFirestore(meal)) ?? [],
      lifestyleChoice: data['lifestyleChoice'] ?? Calorie.MALE_MAINTAIN,
      gender: data['gender'] ?? "Male",
    );
  }

  getName() => this.name;
  getID() => this.id;
  getEmail() => this.email;
  getMeals() => this.meals;
  getCurrentCalories() => this.currentCalories;
  getLifestyleChoice() => this.lifestyleChoice;
  getGender() => this.gender;

  setName(String name) => this.name = name;
  setLifestyleChoice(int value) => this.lifestyleChoice = value;
  setGender(String gender) => this.gender = gender;

  void addMeal(Meal meal) {
    this.meals.add(meal);
    notifyListeners();
  }

  void updateCalorieCount(int value) {
    this.currentCalories += value;
    notifyListeners();
  }
}
