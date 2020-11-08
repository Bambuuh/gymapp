import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/workout_item.dart';
import 'package:gymapp/providers/workout.dart';

class WorkoutList extends StatelessWidget {
  final List<Workout> workouts;
  final Function onPressed;

  WorkoutList(this.workouts, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: workouts.map((workout) => WorkoutItem(workout: workout, onPressed: onPressed)).toList(),
    );
  }
}
