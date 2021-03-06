import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/set_counter.dart';
import 'package:gymapp/util/helpers.dart';

import '../modules/exercise.dart';
import '../providers/workout.dart';

class ExerciseItem extends StatelessWidget {
  final Workout workout;
  final Exercise exercise;
  final Function onPress;

  ExerciseItem(this.workout, this.exercise, this.onPress);

  Widget buildRepetitions() {
    if (exercise.maxReps != null) {
      return Text('Repetitions ${exercise.minReps}-${exercise.maxReps}');
    }

    if (exercise.repetitions != null) {
      final firstVal = exercise.repetitions[0];
      final isFixed = exercise.repetitions.fold(true, (previousValue, nmbr) => nmbr == firstVal);
      if (isFixed) {
        return Text('Repetitions: ${exercise.repetitions[0]}');
      }
      String repetitions = exercise.repetitions.join(', ');
      return Text('Repetitions: $repetitions');
    }

    return Text('Repetitions: to failure');
  }

  void onPressed() {
    onPress(exercise);
  }

  Widget buildRows() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(exercise.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            buildRepetitions(),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${removeDecimalZeroFormat(exercise.lastWeight)} kg'),
            SetCounter(exercise),
          ],
        ),
      ],
    );
  }

  Widget buildItemContainer() {
    const padding = EdgeInsets.all(16);
    if (exercise.completedSets == exercise.sets) {
      return Neumorphic(
        style: NeumorphicStyle(depth: -4),
        padding: padding,
        child: buildRows(),
      );
    }

    return NeumorphicButton(
      onPressed: onPressed,
      padding: padding,
      child: buildRows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      child: Container(
        height: 80,
        child: buildItemContainer(),
      ),
    );
  }
}
