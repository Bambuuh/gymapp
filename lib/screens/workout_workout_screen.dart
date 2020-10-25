import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/workout_list.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/workout.dart';
import 'package:gymapp/screens/workout_exercise_screen.dart';
import 'package:provider/provider.dart';

class WorkoutWorkoutScreen extends StatelessWidget {
  static final String routeName = 'screen/workout_workout_screen';

  void onPressItem(context, Workout workout) {
    final String routineId = ModalRoute.of(context).settings.arguments;
    final arguments = {'routineId': routineId, 'workoutId': workout.id};
    Navigator.pushNamed(
      context,
      WorkoutExerciseScreen.routeName,
      arguments: arguments,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String routineId = ModalRoute.of(context).settings.arguments;
    final routine = Provider.of<RoutineProvider>(context).findById(routineId);
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text('Select Workout'),
      ),
      body: Container(
        child: WorkoutList(routine.workouts, onPressItem),
      ),
    );
  }
}
