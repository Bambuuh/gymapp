import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/services/database/users.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
CollectionReference users = fireStore.collection(USERS_KEY);

const String EXERCISE_HISTORY_KEY = 'exerciseHistories';

CollectionReference _getCollection(String userId) {
  return users.doc(userId).collection(EXERCISE_HISTORY_KEY);
}

Future<void> createExerciseHistory(String userId, int reps, double weight) async {
  Map<String, dynamic> newExerciseHistory = {
    'reps': reps,
    'weight': weight,
  };

  _getCollection(userId).add(newExerciseHistory);
}
