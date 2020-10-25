import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/exercise_list.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:provider/provider.dart';

class WorkoutExerciseScreen extends StatelessWidget {
  static final String routeName = 'screen/workout_exercise_screen';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    final routine = Provider.of<RoutineProvider>(context).findById(args['routineId']);
    final workout = routine.findWorkoutById(args['workoutId']);
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text('Select Exercise'),
      ),
      body: ExerciseList(workout.exercises, () {}),
    );
  }
}
