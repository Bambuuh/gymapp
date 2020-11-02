import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/database/users.dart';
import 'package:gymapp/providers/routine.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
CollectionReference users = fireStore.collection(USERS_KEY);

const String ROUTINES_KEY = 'routines';

CollectionReference _getCollection(String userId) {
  return users.doc(userId).collection(ROUTINES_KEY);
}

Future<void> addRoutine(String userId, Routine routine) async {
  final json = routine.toJson();
  await _getCollection(userId).doc(routine.id).set(json);
}

Future<List<Routine>> getRoutines(String userId) async {
  final snapshot = await _getCollection(userId).get();

  return snapshot.docs.map((e) => Routine.fromJson(e)).toList();
}
