import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/button.dart';
import 'package:gymapp/components/text_field.dart';
import 'package:gymapp/modules/exercise.dart';
import 'package:gymapp/providers/exercise_provider.dart';
import 'package:gymapp/providers/workout_provider.dart';
import 'package:provider/provider.dart';

class AddExerciseScreen extends StatefulWidget {
  static const String routeName = 'screen/add_exercise_screen';

  @override
  _AddExerciseScreenState createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final titleController = TextEditingController();
  final setController = TextEditingController();

  void onPressNewExercise() {
    final exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);

    final String workoutId = ModalRoute.of(context).settings.arguments;
    final newExercise = Exercise(
      title: titleController.text,
      sets: int.parse(
        setController.text,
      ),
    );

    final workout = workoutProvider.findById(workoutId);
    exerciseProvider.addExercise(newExercise);
    workout.addExercise(newExercise);

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
