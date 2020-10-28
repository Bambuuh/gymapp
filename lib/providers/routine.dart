import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/providers/workout.dart';

class Routine with ChangeNotifier {
  String id;
  String title;
  List<Workout> workouts;

  Routine({
    this.id,
    this.workouts,
    @required this.title,
  }) {
    if (id == null) {
      this.id = DateTime.now().toString();
    }
    if (workouts == null) {
      this.workouts = [];
    }
  }

  Workout findWorkoutById(String id) {
    return workouts.firstWhere((workout) => workout.id == id);
  }

  void addWorkout(Workout workout) {
    workouts.add(workout);
    notifyListeners();
  }

  dynamic toJson() {
    return {
      'id': id,
      'title': title,
      'workouts': workouts.map((e) => e.toJson()).toList(),
    };
  }

  static Routine fromJson(json) {
    return Routine(
      title: json['title'],
      id: json['id'],
      workouts: List<Workout>.from(json['workouts'].map((e) => Workout.fromJson(e)).toList()).toList(),
    );
  }
}
