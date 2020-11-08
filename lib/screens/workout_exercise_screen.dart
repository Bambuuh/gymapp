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

  String getPrettyTime({Duration duration, bool hours = true}) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (hours) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void setPrettyTime(Workout workout) {
    setState(() {
      prettySessionTime = getPrettyTime(duration: workout.timeElapsed);
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

  Widget buildWorkoutTitle(Workout workout) {
    if (!workout.isRunning) {
      return Text('Select Exercise');
    } else if (workout.isResting) {
      return Text('Rest: ${getPrettyTime(duration: workout.restRemaining, hours: false)}');
    }

    return Text(prettySessionTime);
  }

  List<Widget> buildActions(Workout workout) {
    void onPressStopWorkout(Workout workout) {
      prettySessionTime = '00:00:00';
      workout.stopWorkout();
      timer.cancel();
      setState(() {});
    }

    if (workout.isResting) {
      return [
        MorphButton(
          child: Container(
            alignment: Alignment.center,
            child: Text('Cancel'),
          ),
          onPressed: workout.cancelRestTimer,
        )
      ];
    }

    return [
      Container(
        child: MorphButton(
          child: Container(
            alignment: Alignment.center,
            child: Text('Reset'),
          ),
          onPressed: () => onPressStopWorkout(workout),
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
    ];
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

    return ChangeNotifierProvider<Workout>.value(
      value: workout,
      child: Scaffold(
        appBar: NeumorphicAppBar(
          title: Consumer<Workout>(
            builder: (_, workout, child) => buildWorkoutTitle(workout),
          ),
          actions: buildActions(workout),
        ),
        body: SingleChildScrollView(child: ExerciseList(workout, onPressExercise)),
      ),
    );
  }
}
