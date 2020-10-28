import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/modules/exercise.dart';

class Workout with ChangeNotifier {
  String id;
  String title;
  List<Exercise> exercises;
  bool _isRunning = false;
  Stopwatch _stopWatch = Stopwatch();

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

  Duration get timeElapsed {
    return _stopWatch.elapsed;
  }

  bool get isRunning {
    return _isRunning && _stopWatch.elapsedMilliseconds > 0;
  }

  bool get isPaused {
    return _stopWatch.elapsedMilliseconds > 0 && !_stopWatch.isRunning;
  }

  void _resetWorkout() {
    _isRunning = false;
    _stopWatch.reset();
    _stopWatch.stop();
    exercises.forEach((exercise) {
      exercise.completedSets = 0;
    });
  }

  void addExercise(Exercise exercise) {
    exercises.add(exercise);
    notifyListeners();
  }

  void startWorkout() {
    _isRunning = true;
    _stopWatch.start();
    notifyListeners();
  }

  void pauseWorkout() {
    _stopWatch.stop();
    notifyListeners();
  }

  void stopWorkout() {
    _resetWorkout();
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }

  static fromJson(json) {
    return Workout(
      id: json['id'],
      title: json['title'],
      exercises: List<Exercise>.from(json['exercises'].map((e) => Exercise.fromJson(e)).toList()),
    );
  }
}
