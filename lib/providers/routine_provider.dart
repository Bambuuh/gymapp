import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/modules/dummy_data.dart';
import 'package:gymapp/modules/exercise.dart';
import 'package:gymapp/providers/routine.dart';
import 'package:gymapp/services/prefs.service.dart';

class RoutineProvider with ChangeNotifier {
  final String prefsKey = 'prefs_routine';
  List<Routine> _routines = [...mockRoutines];
  Routine _currentRoutine;

  RoutineProvider() {
    Prefs.getObjectByKey(prefsKey).then((data) {
      if (data != null) {
        // _routines = List<Routine>.from(data.map((e) => Routine.fromJson(e)).toList());
        notifyListeners();
      }
    });
  }

  void setCurrentRoutine(Routine routine) {
    _currentRoutine = routine;
    notifyListeners();
  }

  Routine get currentRoutine {
    return _currentRoutine;
  }

  void saveData() {
    Prefs.storeObjectByKey(prefsKey, _routines);
  }

  List<Routine> get routines {
    return [..._routines];
  }

  void setRoutines(List<Routine> routines) {
    _routines = [...routines];
    notifyListeners();
  }

  void updateExercises(List<Exercise> updatedExercises) {
    _routines.forEach((routine) {
      routine.workouts.forEach((workout) {
        workout.exercises.forEach((exercise) {
          var updated = updatedExercises.firstWhere((e) => e.id == exercise.id);
          if (updated != null) {
            exercise = Exercise.fromJson(updated.toJson());
          }
        });
      });
    });
    notifyListeners();
  }

  void addRoutine(Routine routine) {
    _routines.add(routine);
    notifyListeners();
  }

  Routine findById(String id) {
    return _routines.firstWhere((routine) => routine.id == id);
  }
}
