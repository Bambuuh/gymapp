import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Exercise {
  String id;
  String title;
  int sets;
  List<int> repetitions;
  int minReps;
  int maxReps;

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
}
