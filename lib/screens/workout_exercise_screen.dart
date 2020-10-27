import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/button.dart';
import 'package:gymapp/components/exercise_list.dart';
import 'package:gymapp/modules/exercise.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/workout.dart';
import 'package:gymapp/screens/select_repetitions_screen.dart';
import 'package:provider/provider.dart';

class WorkoutExerciseScreen extends StatefulWidget {
  static final String routeName = 'screen/workout_exercise_screen';

  @override
  _WorkoutExerciseScreenState createState() => _WorkoutExerciseScreenState();
}

class _WorkoutExerciseScreenState extends State<WorkoutExerciseScreen> {
  Timer timer;
  String prettySessionTime = '';

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void callback(Timer timer, Workout workout) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(workout.timeElapsed.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(workout.timeElapsed.inSeconds.remainder(60));
    setState(() {
      prettySessionTime = "${twoDigits(workout.timeElapsed.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    });
  }

  void startWorkout(Workout workout) {
    workout.startWorkout();
    Function cb = (Timer timer) {
      callback(timer, workout);
    };
    timer = new Timer.periodic(new Duration(milliseconds: 30), cb);
  }

  void onPressTopRight(Workout workout) {
    if (workout.isRunning && !workout.isPaused) {
      workout.pauseWorkout();
      timer.cancel();
    } else {
      startWorkout(workout);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    final routine = Provider.of<RoutineProvider>(context).findById(args['routineId']);
    final workout = routine.findWorkoutById(args['workoutId']);

    void onPressExercise(Exercise exercise) {
      if (!workout.isRunning) {
        startWorkout(workout);
      }
      Navigator.of(context)
          .pushNamed(SelectRepetitionsScreen.routeName, arguments: exercise)
          .then((value) => setState(() {}));
    }

    return ChangeNotifierProvider<Workout>.value(
      value: workout,
      child: Scaffold(
        appBar: NeumorphicAppBar(
          title: Consumer<Workout>(
            builder: (_, workout, child) => workout.isRunning ? Text(prettySessionTime) : Text('Select Exercise'),
          ),
          actions: [
            MorphButton(
              child: Container(
                alignment: Alignment.center,
                child: Text('Stop'),
              ),
              onPressed: workout.stopWorkout,
            ),
            Consumer<Workout>(
              builder: (_, workout, child) => MorphButton(
                child: Container(
                  alignment: Alignment.center,
                  child: !workout.isPaused && workout.isRunning ? Text('Pause') : Text('Start'),
                ),
                onPressed: () => onPressTopRight(workout),
              ),
            )
          ],
        ),
        body: ExerciseList(workout, onPressExercise),
      ),
    );
  }
}
