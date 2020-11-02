import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/MorphButton.dart';
import 'package:gymapp/components/text_field.dart';
import 'package:gymapp/database/exercies_db.dart';
import 'package:gymapp/database/routines_db.dart';
import 'package:gymapp/database/workout_db.dart';
import 'package:gymapp/modules/exercise.dart';
import 'package:gymapp/providers/exercise_provider.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/user_provider.dart';
import 'package:gymapp/providers/workout_provider.dart';
import 'package:provider/provider.dart';

class AddExerciseScreenArgs {
  String workoutId;
  String routineId;

  AddExerciseScreenArgs(this.workoutId, this.routineId);
}

class AddExerciseScreen extends StatefulWidget {
  static const String routeName = 'screen/add_exercise_screen';

  @override
  _AddExerciseScreenState createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final titleController = TextEditingController();
  final setController = TextEditingController();

  void onPressNewExercise() {
    final userId = Provider.of<UserProvider>(context, listen: false).user.id;
    final exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    final routineProvider = Provider.of<RoutineProvider>(context, listen: false);

    final args = ModalRoute.of(context).settings.arguments as AddExerciseScreenArgs;
    final newExercise = Exercise(
      title: titleController.text,
      sets: int.parse(setController.text),
    );

    final routine = routineProvider.findById(args.routineId);
    final workout = workoutProvider.findById(args.workoutId);
    routine.workouts.removeWhere((w) => w.id == workout.id);

    exerciseProvider.addExercise(newExercise);
    workout.addExercise(newExercise);
    routine.addWorkout(workout);

    setExercise(userId, newExercise);
    setWorkout(userId, workout);
    setRoutine(userId, routine);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: NeumorphicAppBar(title: Text('Add Exercise')),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              MorphButton(
                child: Text('Add Existing Exercise'),
                onPressed: () => {},
                margin: EdgeInsets.only(bottom: 32),
              ),
              NeumorphicTextField(
                  autoFocus: true,
                  controller: titleController,
                  placeholder: 'Title',
                  margin: EdgeInsets.only(
                    bottom: 16,
                  )),
              NeumorphicTextField(
                controller: setController,
                placeholder: 'Sets',
                keyboardType: TextInputType.number,
              ),
              MorphButton(
                child: Text('Create Workout'),
                onPressed: () => onPressNewExercise(),
                margin: EdgeInsets.only(top: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
