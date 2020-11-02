import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/database/users.dart';
import 'package:gymapp/modules/exercise.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
CollectionReference users = fireStore.collection(USERS_KEY);

const String EXERCISES_KEY = 'exercises';

CollectionReference _getCollection(String userId) {
  return users.doc(userId).collection(EXERCISES_KEY);
}

Future<void> setExercise(String userId, Exercise exercise) async {
  final json = exercise.toJson();
  await _getCollection(userId).doc(exercise.id).set(json);
}

Future<List<Exercise>> getAllExercises(String userId) async {
  final snapshot = await _getCollection(userId).get();
  return snapshot.docs.map((e) => Exercise.fromJson(e)).toList();
}
