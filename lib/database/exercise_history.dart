import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/database/users.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
CollectionReference users = fireStore.collection(USERS_KEY);

const String EXERCISE_HISTORY_KEY = 'exerciseHistories';

CollectionReference _getCollection(String userId) {
  return users.doc(userId).collection(EXERCISE_HISTORY_KEY);
}

Future<void> createExerciseHistory(String userId, int reps, double weight, String id) async {
  Map<String, dynamic> newExerciseHistory = {
    'exerciseId': id,
    'reps': reps,
    'weight': weight,
  };

  _getCollection(userId).add(newExerciseHistory);
}

Future<void> getExerciseHistory(String userId) async {
  final snapshot = await _getCollection(userId).get();
  print('===========================');
  snapshot.docs.forEach((element) {
    print(element['reps']);
  });
  print('===========================');
}
