import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/modules/dummy_data.dart';
import 'package:gymapp/providers/workout.dart';

class WorkoutProvider with ChangeNotifier {
  // List<Workout> _workouts = [];
  List<Workout> _workouts = [...mockWorkouts];

  List<Workout> get workouts {
    return [..._workouts];
  }

  void setWorkouts(List<Workout> workouts) {
    _workouts = [...workouts];
    notifyListeners();
  }

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  Workout findById(String id) {
    return _workouts.firstWhere((workout) => workout.id == id);
  }
}
