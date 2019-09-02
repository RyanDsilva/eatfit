import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatfit/models/meal.dart';
import 'package:eatfit/models/user.dart';

class DatabaseService {
  final firestoreDB = Firestore.instance;

  Stream<User> getUser(String id) {
    return firestoreDB
        .collection('users')
        .document(id)
        .snapshots()
        .map((doc) => User.fromFirestore(doc));
  }

  Stream<List<Meal>> getMeals(String id) {
    return firestoreDB
        .collection('users')
        .document(id)
        .collection('meals')
        .snapshots()
        .map((list) =>
            list.documents.map((meal) => Meal.fromFirestore(meal)).toList());
  }

  Future<void> createUser(User user) {
    return firestoreDB.collection('users').add({
      'name': user.name,
      'lifestyleChoice': user.lifestyleChoice,
      'gender': user.gender,
      'meals': [],
      'currentCalories': 0
    });
  }
}
