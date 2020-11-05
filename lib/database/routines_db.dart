import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/database/exercises_db.dart';
import 'package:gymapp/database/users.dart';
import 'package:gymapp/database/workout_db.dart';
import 'package:gymapp/providers/routine.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
CollectionReference users = fireStore.collection(USERS_KEY);

const String ROUTINES_KEY = 'routines';

class RoutinesDB {
  static CollectionReference _getCollection(String userId) {
    return users.doc(userId).collection(ROUTINES_KEY);
  }

  static Future<void> setExerciseResult(
      String userId, String routineId, String workoutId, String exerciseId, int reps, double weight) async {
    final json = {
      'lastReps': reps,
      'lastWeight': weight,
    };
    await _getCollection(userId)
        .doc(routineId)
        .collection(WORKOUT_KEY)
        .doc(workoutId)
        .collection(EXERCISES_KEY)
        .doc(exerciseId)
        .set(json);
  }

  static Future<void> setRoutine(String userId, Routine routine) async {
    final json = routine.toJson();
    await _getCollection(userId).doc(routine.id).set(json);
  }

  static Future<List<Routine>> getAllRoutines(String userId) async {
    final snapshot = await _getCollection(userId).get();
    return snapshot.docs.map((e) => Routine.fromJson(e)).toList();
  }
}
