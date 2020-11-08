import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/workout_item.dart';
import 'package:gymapp/database/routines_db.dart';
import 'package:gymapp/providers/routine.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/user_provider.dart';
import 'package:gymapp/providers/workout.dart';
import 'package:gymapp/screens/add_workout_screen.dart';
import 'package:gymapp/screens/workout_screen.dart';
import 'package:provider/provider.dart';

class RoutineScreenArgs {
  Routine routine;
  RoutineScreenArgs(this.routine);
}

class RoutineScreen extends StatefulWidget {
  static final String routeName = 'screens/routine_screen';

  @override
  _RoutineScreenState createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  void onPressItem(context, Workout workout) {
    final args = ModalRoute.of(context).settings.arguments as RoutineScreenArgs;
    final arguments = {'routineId': args.routine.id, 'workoutId': workout.id};
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
    final args = ModalRoute.of(context).settings.arguments as RoutineScreenArgs;
    final routine = Provider.of<RoutineProvider>(context).findById(args.routine.id);
    final workouts = routine.workouts;

    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text(routine.title),
      ),
      body: Container(
        child: ReorderableListView(
          children: workouts
              .map((workout) => WorkoutItem(key: Key(workout.id), workout: workout, onPressed: onPressItem))
              .toList(),
          onReorder: (int start, int current) {
            Workout startItem = workouts[start];
            if (start < current) {
              int end = current - 1;
              int i = 0;
              int local = start;

              do {
                workouts[local] = workouts[++local];
                i++;
              } while (i < end - start);
              workouts[end] = startItem;
            } else if (start > current) {
              for (int i = start; i > current; i--) {
                workouts[i] = workouts[i - 1];
              }
              workouts[current] = startItem;
            }
            setState(() {
              final userId = Provider.of<UserProvider>(context, listen: false).user.id;
              RoutinesDB.setRoutine(userId, routine);
            });
          },
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
