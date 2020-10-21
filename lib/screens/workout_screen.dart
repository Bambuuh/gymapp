import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/exercise_item.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/screens/add_exercise_screen.dart';
import 'package:provider/provider.dart';

class WorkoutScreen extends StatefulWidget {
  static final String routeName = 'screen/workout_screen';

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    final routine = Provider.of<RoutineProvider>(context).findById(args['routineId']);
    final workout = routine.findWorkoutById(args['workoutId']);
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text(workout.title),
      ),
      body: Column(
        children: workout.exercises.map((exercise) => ExerciseItem(exercise)).toList(),
      ),
      floatingActionButton: NeumorphicButton(
        style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
        onPressed: () {
          Navigator.of(context).pushNamed(AddExerciseScreen.routeName, arguments: workout.id);
        },
        tooltip: 'Add workout',
        child: Icon(Icons.add),
      ),
    );
  }
}
