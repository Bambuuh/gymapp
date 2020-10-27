import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/exercise_item.dart';

import '../providers/workout.dart';

class ExerciseList extends StatelessWidget {
  final Workout workout;
  final Function onPressItem;

  ExerciseList(this.workout, this.onPressItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: workout.exercises.map((exercise) => ExerciseItem(workout, exercise, onPressItem)).toList(),
      ),
    );
  }
}
