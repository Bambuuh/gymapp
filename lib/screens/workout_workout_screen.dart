import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/workout_list.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/workout.dart';
import 'package:gymapp/providers/workout_provider.dart';
import 'package:gymapp/screens/workout_exercise_screen.dart';
import 'package:provider/provider.dart';

class WorkoutWorkoutScreen extends StatelessWidget {
  static final String routeName = 'screen/workout_workout_screen';

  void onPressItem(context, Workout workout) {
    Provider.of<WorkoutProvider>(context, listen: false).setCurrentWorkout(workout);
    Navigator.pushNamed(
      context,
      WorkoutExerciseScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routine = Provider.of<RoutineProvider>(context).currentRoutine;
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
