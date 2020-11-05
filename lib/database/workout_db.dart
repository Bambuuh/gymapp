import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/database/users.dart';
import 'package:gymapp/providers/workout.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
CollectionReference users = fireStore.collection(USERS_KEY);

const String WORKOUT_KEY = 'workouts';

class WorkoutsDB {
  static CollectionReference _getCollection(String userId) {
    return users.doc(userId).collection(WORKOUT_KEY);
  }

  static Future<void> setWorkout(String userId, Workout workout) async {
    final json = workout.toJson();
    await _getCollection(userId).doc(workout.id).set(json);
  }

  static Future<List<Workout>> getAllWorkouts(String userId) async {
    final snapshot = await _getCollection(userId).get();
    return snapshot.docs.map((e) => Workout.fromJson(e)).toList();
  }
}
