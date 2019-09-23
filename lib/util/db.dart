import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> updateUser(Map data, String id) {
    return firestoreDB.collection('users').document(id).updateData(data);
  }
}
