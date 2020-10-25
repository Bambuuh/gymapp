import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/workout_item.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/screens/add_workout_screen.dart';
import 'package:gymapp/screens/workout_screen.dart';
import 'package:provider/provider.dart';

class RoutineScreen extends StatefulWidget {
  static final String routeName = 'screens/routine_screen';

  @override
  _RoutineScreenState createState() => _RoutineScreenState();
}

Widget buildRoutineItem(context, workout, routine) {
  final arguments = {'routineId': routine.id, 'workoutId': workout.id};
  final onPressed = () => Navigator.pushNamed(
        context,
        WorkoutScreen.routeName,
        arguments: arguments,
      );
  return WorkoutItem(
    workout: workout,
    routineId: routine.id,
    onPressed: onPressed,
  );
}

class _RoutineScreenState extends State<RoutineScreen> {
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
      body: Container(
        child: Column(
          children: routine.workouts
              .map((workout) =>
                  ChangeNotifierProvider.value(value: workout, child: buildRoutineItem(context, workout, routine)))
              .toList(),
        ),
      ),
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
