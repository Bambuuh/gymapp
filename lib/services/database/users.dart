import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/modules/user.dart';

const USERS_KEY = 'users';
CollectionReference users = fireStore.collection(USERS_KEY);
FirebaseFirestore fireStore = FirebaseFirestore.instance;

Future<User> createUser(String id) async {
  Map<String, dynamic> newUser = {'id': id};

  await users.doc(id).set(newUser);
  return User.fromJson(newUser);
}

Future<User> getUser(String id) async {
  final user = await users.doc(id).get();
  if (user.data() != null) {
    return User.fromJson(user.data());
  }
  return null;
}
