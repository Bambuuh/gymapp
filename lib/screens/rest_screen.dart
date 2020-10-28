import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/button.dart';
import 'package:gymapp/modules/exercise.dart';
import 'package:gymapp/screens/workout_exercise_screen.dart';

class RestScreen extends StatefulWidget {
  static final String routeName = 'screen/rest_screen';

  @override
  _RestScreenState createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> with SingleTickerProviderStateMixin {
  Animation<int> animation;
  AnimationController controller;
  String prettySessionTime = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final exercise = ModalRoute.of(context).settings.arguments as Exercise;
      controller = AnimationController(duration: Duration(seconds: exercise.restSeconds), vsync: this);
      animation = StepTween(begin: exercise.restSeconds, end: 0).animate(controller)
        ..addListener(() {
          setState(() {
            Duration current = Duration(seconds: animation.value);
            String twoDigits(int n) => n.toString().padLeft(2, "0");
            String twoDigitMinutes = twoDigits(current.inMinutes.remainder(60));
            String twoDigitSeconds = twoDigits(current.inSeconds.remainder(60));
            prettySessionTime = "$twoDigitMinutes:$twoDigitSeconds";
          });

          if (animation.isCompleted) {
            Navigator.of(context).popUntil((route) => route.settings.name == WorkoutExerciseScreen.routeName);
          }
        });
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onPressCancel() {
    Navigator.of(context).popUntil((route) => route.settings.name == WorkoutExerciseScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 32),
                child: Text(
                  prettySessionTime,
                  style: TextStyle(fontSize: 60),
                ),
              ),
              MorphButton(child: Text('Cancel'), onPressed: onPressCancel),
            ],
          ),
        ),
      ),
    );
  }
}
