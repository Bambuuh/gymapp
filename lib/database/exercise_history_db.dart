import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/database/users.dart';
import 'package:gymapp/modules/exercise_history.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
CollectionReference users = fireStore.collection(USERS_KEY);

const String EXERCISE_HISTORY_KEY = 'exerciseHistories';

class ExerciseHistoryDB {
  static CollectionReference _getCollection(String userId) {
    return users.doc(userId).collection(EXERCISE_HISTORY_KEY);
  }

  static Future<void> createExerciseHistory(String userId, ExerciseHistory exerciseHistory) async {
    _getCollection(userId).add(exerciseHistory.toJson());
  }

  static Future<List<ExerciseHistory>> getExerciseHistory(String userId) async {
    final snapshot = await _getCollection(userId).get();
    return snapshot.docs.map((e) => ExerciseHistory.fromJson(e)).toList();
  }
}
