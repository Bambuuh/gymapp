import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/database/util.dart';

class Exercise {
  String id;
  String title;
  int sets;
  List<int> repetitions;
  int minReps;
  int maxReps;
  int lastReps;
  double lastWeight;
  int completedSets = 0;
  int restSeconds;

  Exercise({
    this.id,
    @required this.title,
    @required this.sets,
    this.repetitions,
    this.minReps,
    this.maxReps,
    this.lastReps = 0,
    this.lastWeight = 0,
    this.restSeconds = 120,
  }) {
    if (id == null) {
      this.id = getUUID('exercise');
    }
  }

  void setWeight(double newWeight) {
    lastWeight = newWeight;
  }

  void completeSet(int reps, double weight) {
    completedSets++;
    lastReps = reps;
    lastWeight = weight;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'sets': sets,
      'repetitions': repetitions,
      'minReps': minReps,
      'maxReps': maxReps,
      'lastReps': lastReps,
      'lastWeight': lastWeight,
      'restSeconds': restSeconds
    };
  }

  static Exercise fromJson(json) {
    final obj = Exercise(
      id: json['id'],
      title: json['title'],
      sets: json['sets'],
      repetitions: null,
      minReps: json['minReps'],
      maxReps: json['maxReps'],
      lastReps: json['lastReps'],
      lastWeight: json['lastWeight'],
      restSeconds: json['restSeconds'],
    );
    if (json['repetitions'] != null) {
      obj.repetitions = List<int>.from(json['repetitions'].toList());
    }
    return obj;
  }
}
