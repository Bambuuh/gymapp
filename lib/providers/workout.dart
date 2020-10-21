import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/modules/exercise.dart';

class Workout with ChangeNotifier {
  String id;
  String title;
  List<Exercise> exercises;

  Workout({
    this.id,
    this.exercises,
    @required this.title,
  }) {
    if (id == null) {
      this.id = DateTime.now().toString();
    }
    if (exercises == null) {
      this.exercises = [];
    }
  }

  Exercise findExerciseById(String id) {
    return exercises.firstWhere((exercise) => exercise.id == id);
  }

  void addExercise(Exercise exercise) {
    exercises.add(exercise);
    notifyListeners();
  }
}
