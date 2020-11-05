import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/MorphButton.dart';
import 'package:gymapp/components/text_field.dart';
import 'package:gymapp/database/routines_db.dart';
import 'package:gymapp/database/workout_db.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/user_provider.dart';
import 'package:gymapp/providers/workout.dart';
import 'package:gymapp/providers/workout_provider.dart';
import 'package:gymapp/screens/workout_screen.dart';
import 'package:provider/provider.dart';

class AddWorkoutScreen extends StatefulWidget {
  static const String routeName = 'screen/add_workout_screen';

  @override
  _AddWorkoutScreenState createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final titleController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  void onPressNewWorkout(context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    final routineProvider = Provider.of<RoutineProvider>(context, listen: false);
    final userId = Provider.of<UserProvider>(context, listen: false).user.id;

    final String routineId = ModalRoute.of(context).settings.arguments;
    final newWorkout = Workout(title: titleController.text);

    final routine = routineProvider.findById(routineId);
    workoutProvider.addWorkout(newWorkout);
    routine.addWorkout(newWorkout);
    RoutinesDB.setRoutine(userId, routine);
    WorkoutsDB.setWorkout(userId, newWorkout);

    Navigator.of(context).pushReplacementNamed(
      WorkoutScreen.routeName,
      arguments: {'routineId': routineId, 'workoutId': newWorkout.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(title: Text('Add Workout')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            MorphButton(
              child: Text('Use Existing Workout'),
              onPressed: () => {},
              margin: EdgeInsets.only(bottom: 32),
            ),
            NeumorphicTextField(
              controller: titleController,
              placeholder: 'Title',
              autoFocus: true,
            ),
            MorphButton(
              child: Text('Create Workout'),
              onPressed: () => onPressNewWorkout(context),
              margin: EdgeInsets.only(top: 32),
            ),
          ],
        ),
      ),
    );
  }
}
