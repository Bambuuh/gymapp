import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Exercise {
  String id;
  String title;
  int sets;
  List<int> repetitions;
  int minReps;
  int maxReps;
  int lastReps = 0;
  double lastWeight = 0;
  int completedSets = 0;
  int restSeconds = 60;

  Exercise({
    this.id,
    @required this.title,
    @required this.sets,
    this.repetitions,
    this.minReps,
    this.maxReps,
  }) {
    if (id == null) {
      this.id = DateTime.now().toString();
    }
  }

  void setWeight(double newWeight) {
    lastWeight = newWeight;
  }

  void completeSet() {
    completedSets++;
  }
}
