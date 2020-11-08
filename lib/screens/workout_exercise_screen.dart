import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/MorphButton.dart';
import 'package:gymapp/components/exercise_list.dart';
import 'package:gymapp/modules/exercise.dart';
import 'package:gymapp/providers/exercise_provider.dart';
import 'package:gymapp/providers/workout.dart';
import 'package:gymapp/providers/workout_provider.dart';
import 'package:gymapp/screens/select_repetitions_screen.dart';
import 'package:provider/provider.dart';

class WorkoutExerciseScreen extends StatefulWidget {
  static final String routeName = 'screen/workout_exercise_screen';

  @override
  _WorkoutExerciseScreenState createState() => _WorkoutExerciseScreenState();
}

class _WorkoutExerciseScreenState extends State<WorkoutExerciseScreen> {
  Timer timer;
  String prettySessionTime = '00:00:00';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final workout = Provider.of<WorkoutProvider>(context, listen: false).currentWorkout;
      if (workout.isRunning && !workout.isPaused) {
        startTimer(workout);
        setPrettyTime(workout);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }

  void setPrettyTime(Workout workout) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(workout.timeElapsed.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(workout.timeElapsed.inSeconds.remainder(60));
    setState(() {
      prettySessionTime = "${twoDigits(workout.timeElapsed.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    });
  }

  void startTimer(Workout workout) {
    Function cb = (Timer timer) {
      setPrettyTime(workout);
    };
    timer = new Timer.periodic(new Duration(seconds: 1), cb);
  }

  void startWorkout(Workout workout) {
    workout.startWorkout();
    startTimer(workout);
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
    final workout = Provider.of<WorkoutProvider>(context).currentWorkout;

    void onPressExercise(Exercise exercise) {
      if (!workout.isRunning) {
        startWorkout(workout);
      }
      Provider.of<ExerciseProvider>(context, listen: false).setCurrentExercise(exercise);
      Navigator.of(context).pushNamed(SelectRepetitionsScreen.routeName).then((value) => setState(() {}));
    }

    void onPressStopWorkout() {
      prettySessionTime = '00:00:00';
      workout.stopWorkout();
      timer.cancel();
      setState(() {});
    }

    return ChangeNotifierProvider<Workout>.value(
      value: workout,
      child: Scaffold(
        appBar: NeumorphicAppBar(
          title: Consumer<Workout>(
            builder: (_, workout, child) => workout.isRunning ? Text(prettySessionTime) : Text('Select Exercise'),
          ),
          actions: [
            Container(
              child: MorphButton(
                child: Container(
                  alignment: Alignment.center,
                  child: Text('Reset'),
                ),
                onPressed: onPressStopWorkout,
              ),
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
        body: SingleChildScrollView(child: ExerciseList(workout, onPressExercise)),
      ),
    );
  }
}
