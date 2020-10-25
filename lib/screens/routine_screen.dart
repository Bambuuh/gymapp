import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/workout_list.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/workout.dart';
import 'package:gymapp/screens/add_workout_screen.dart';
import 'package:gymapp/screens/workout_screen.dart';
import 'package:provider/provider.dart';

class RoutineScreen extends StatefulWidget {
  static final String routeName = 'screens/routine_screen';

  @override
  _RoutineScreenState createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  void onPressItem(context, Workout workout) {
    final String routineId = ModalRoute.of(context).settings.arguments;
    final arguments = {'routineId': routineId, 'workoutId': workout.id};
    Navigator.pushNamed(
      context,
      WorkoutScreen.routeName,
      arguments: arguments,
    );
  }

  void onBack(_) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String routineId = ModalRoute.of(context).settings.arguments;
    final routine = Provider.of<RoutineProvider>(context).findById(routineId);

    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text(routine.title),
      ),
      body: Container(child: WorkoutList(routine.workouts, onPressItem)),
      floatingActionButton: NeumorphicButton(
        style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
        onPressed: () {
          Navigator.of(context).pushNamed(AddWorkoutScreen.routeName, arguments: routine.id).then(onBack);
        },
        tooltip: 'Add workout',
        child: Icon(Icons.add),
      ),
    );
  }
}
