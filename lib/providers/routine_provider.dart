import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/providers/routine.dart';
import 'package:gymapp/modules/dummy_data.dart';

class RoutineProvider with ChangeNotifier {
  // List<Workout> _workouts = [];
  List<Routine> _routines = [...mockRoutines];

  List<Routine> get routines {
    return [..._routines];
  }

  void addRoutine(Routine routine) {
    _routines.add(routine);
    notifyListeners();
  }

  Routine findById(String id) {
    return _routines.firstWhere((routine) => routine.id == id);
  }
}
