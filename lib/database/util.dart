import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;

String getUUID(String key) {
  return fireStore.collection(key).doc().id;
}
