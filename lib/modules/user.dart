import 'package:flutter/material.dart';

class User {
  String id;
  User({@required this.id});

  toJson() {
    return {'id': id};
  }

  static fromJson(json) {
    return User(id: json['id']);
  }
}
