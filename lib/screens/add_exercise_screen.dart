import 'dart:math';

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
  final repetitionController = TextEditingController();
  final minRepController = TextEditingController();
  final maxRepController = TextEditingController();
  final List<TextEditingController> variedControllers = [];
  bool isVariedRepetitions = false;
  String groupValue = 'regular';

  void onPressNewExercise() {
    if (titleController.text.isEmpty) {
      return;
    }
    final userId = Provider.of<UserProvider>(context, listen: false).user.id;
    final exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    final routineProvider = Provider.of<RoutineProvider>(context, listen: false);

    final args = ModalRoute.of(context).settings.arguments as AddExerciseScreenArgs;
    List<int> repetitions = [];
    if (groupValue == 'varied') {
      if (variedControllers.any((c) => c.text.isEmpty)) {
        return;
      }
      repetitions = variedControllers.map((e) => int.parse(e.text)).toList();
    } else if (groupValue == 'range') {
      if (minRepController.text.isEmpty || maxRepController.text.isEmpty) {
        return;
      }
      repetitions = [];
    } else {
      if (repetitionController.text.isEmpty) {
        return;
      }
      int reps = int.parse(repetitionController.text);
      for (int i = 0; i < reps; i++) {
        repetitions.add(reps);
      }
    }
    final newExercise = Exercise(
      title: titleController.text,
      sets: int.parse(setController.text),
      repetitions: repetitions,
    );

    if (groupValue == 'range') {
      newExercise.minReps = int.parse(minRepController.text);
      newExercise.maxReps = int.parse(maxRepController.text);
    }

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

  var inputMargin = EdgeInsets.only(bottom: 32);

  void onPressRepRadioButton(String newValue) {
    print(newValue);
    if (newValue == 'varied') {
      int reps = setController.text.isEmpty ? 0 : int.parse(setController.text);
      int amount = max(reps, 1);
      for (int i = 0; i < amount; i++) {
        var controller = TextEditingController();
        variedControllers.add(controller);
      }
    } else {
      variedControllers.clear();
    }

    setState(() {
      groupValue = newValue;
    });
  }

  Widget buildVariedRepetitions() {
    List<Widget> inputs = [];
    int reps = setController.text.isEmpty ? 0 : int.parse(setController.text);
    int amount = max(reps, 1);
    for (int i = 0; i < amount; i++) {
      final controller = variedControllers[i];
      inputs.add(
        Container(
            width: 80,
            margin: EdgeInsets.only(right: 8, bottom: 8),
            child: NeumorphicTextField(
              keyboardType: TextInputType.number,
              placeholder: '${i + 1}',
              controller: controller,
            )),
      );
    }
    return Wrap(children: inputs);
  }

  Widget buildRepetitionsInput() {
    if (groupValue == 'varied') {
      return buildVariedRepetitions();
    }

    if (groupValue == 'range') {
      return Container(
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: 110,
              margin: EdgeInsets.only(right: 16),
              child: NeumorphicTextField(
                controller: minRepController,
                placeholder: 'Min Rep',
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              width: 110,
              child: NeumorphicTextField(
                controller: maxRepController,
                placeholder: 'Max Rep',
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      );
    }

    return NeumorphicTextField(
      keyboardType: TextInputType.number,
      controller: repetitionController,
      placeholder: 'Repetitions',
      margin: inputMargin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: NeumorphicAppBar(title: Text('Add Exercise')),
        body: SingleChildScrollView(
          child: Container(
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
                  margin: inputMargin,
                ),
                NeumorphicTextField(
                  controller: setController,
                  placeholder: 'Sets',
                  keyboardType: TextInputType.number,
                  margin: inputMargin,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(children: [
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          child: NeumorphicRadio<String>(
                            groupValue: groupValue,
                            value: 'regular',
                            onChanged: onPressRepRadioButton,
                            child: Text('Regular'),
                            padding: EdgeInsets.all(8),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          child: NeumorphicRadio<String>(
                            groupValue: groupValue,
                            value: 'varied',
                            onChanged: onPressRepRadioButton,
                            child: Text('Varied'),
                            padding: EdgeInsets.all(8),
                          ),
                        ),
                        Container(
                          child: NeumorphicRadio<String>(
                            groupValue: groupValue,
                            value: 'range',
                            onChanged: onPressRepRadioButton,
                            child: Text('Range'),
                            padding: EdgeInsets.all(8),
                          ),
                        ),
                      ]),
                    ),
                    buildRepetitionsInput(),
                  ],
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
      ),
    );
  }
}
