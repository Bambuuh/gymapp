import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/database/util.dart';
import 'package:gymapp/modules/exercise.dart';

class Workout with ChangeNotifier {
  String id;
  String title;
  List<Exercise> exercises;
  bool _isRunning = false;
  Stopwatch _workoutStopWatch = Stopwatch();
  Stopwatch _restStopWatch = Stopwatch();
  Timer _restTimer;
  int _totalRestSeconds;

  Workout({
    this.id,
    this.exercises,
    @required this.title,
  }) {
    if (id == null) {
      this.id = getUUID('workout');
    }
    if (exercises == null) {
      this.exercises = [];
    }
  }

  Exercise findExerciseById(String id) {
    return exercises.firstWhere((exercise) => exercise.id == id);
  }

  Duration get timeElapsed {
    return _workoutStopWatch.elapsed;
  }

  Duration get restRemaining {
    return Duration(seconds: _totalRestSeconds - _restStopWatch.elapsed.inSeconds);
  }

  bool get isRunning {
    return _isRunning && _workoutStopWatch.elapsedMilliseconds > 0;
  }

  bool get isPaused {
    return _workoutStopWatch.elapsedMilliseconds > 0 && !_workoutStopWatch.isRunning;
  }

  bool get isResting {
    return _restStopWatch.isRunning;
  }

  void _resetWorkout() {
    _isRunning = false;
    _workoutStopWatch.reset();
    _workoutStopWatch.stop();
    exercises.forEach((exercise) {
      exercise.completedSets = 0;
    });
  }

  void addExercise(Exercise exercise) {
    exercises.add(exercise);
    notifyListeners();
  }

  void startRestTimer(int seconds) {
    _restStopWatch.reset();
    _totalRestSeconds = seconds;
    _restStopWatch.start();
    _restTimer = Timer(Duration(seconds: seconds), () {
      _restStopWatch.stop();
      notifyListeners();
    });
    notifyListeners();
  }

  void cancelRestTimer() {
    _restStopWatch.reset();
    _restStopWatch.stop();
    _restTimer.cancel();
    notifyListeners();
  }

  void startWorkout() {
    _isRunning = true;
    _workoutStopWatch.start();
    notifyListeners();
  }

  void pauseWorkout() {
    _workoutStopWatch.stop();
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

  static Workout fromJson(json) {
    return Workout(
      id: json['id'],
      title: json['title'],
      exercises: List<Exercise>.from(json['exercises'].map((e) => Exercise.fromJson(e)).toList()),
    );
  }
}
