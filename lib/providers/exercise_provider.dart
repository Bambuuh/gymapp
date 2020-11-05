import 'package:flutter/material.dart';
import 'package:gymapp/modules/exercise.dart';

class ExerciseProvider with ChangeNotifier {
  List<Exercise> _exercises = [];
  Exercise _currentExercise;

  List<Exercise> get exercises {
    return [..._exercises];
  }

  Exercise get currentExercise {
    return _currentExercise;
  }

  void setExercises(List<Exercise> exercises) {
    _exercises = [...exercises];
    notifyListeners();
  }

  void setCurrentExercise(Exercise exercise) {
    _currentExercise = exercise;
    notifyListeners();
  }

  void addExercise(Exercise exercise) {
    _exercises.add(exercise);
    notifyListeners();
  }

  Exercise findById(String id) {
    return _exercises.firstWhere((exercise) => exercise.id == id);
  }
}
