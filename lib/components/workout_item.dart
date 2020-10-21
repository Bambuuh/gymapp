import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/providers/workout.dart';

class WorkoutItem extends StatelessWidget {
  final Workout workout;
  final String routineId;
  final Function onPressed;

  WorkoutItem({
    @required this.workout,
    @required this.onPressed,
    this.routineId,
  });

  // void onPressItem(context) {
  //   Navigator.pushNamed(
  //     context,
  //     WorkoutScreen.routeName,
  //     arguments: {'routineId': routineId, 'workoutId': workout.id},
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: NeumorphicButton(
          onPressed: onPressed,
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
