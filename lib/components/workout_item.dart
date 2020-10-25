import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/providers/workout.dart';

class WorkoutItem extends StatelessWidget {
  final Workout workout;
  final Function onPressed;

  WorkoutItem(
    this.workout,
    this.onPressed,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: NeumorphicButton(
          onPressed: () => onPressed(context, workout),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            child: Text(
              workout.title,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
