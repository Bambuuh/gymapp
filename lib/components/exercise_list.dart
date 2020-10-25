import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/exercise_item.dart';
import 'package:gymapp/modules/exercise.dart';

class ExerciseList extends StatelessWidget {
  final List<Exercise> exercises;
  final Function onPressItem;

  ExerciseList(this.exercises, this.onPressItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: exercises.map((exercise) => ExerciseItem(exercise, onPressItem)).toList(),
      ),
    );
  }
}
