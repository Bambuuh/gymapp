import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
        return Text('Repetitions ${exercise.repetitions[0]}');
      }
      String repetitions = exercise.repetitions.join(', ');
      return Text('Repetitions $repetitions');
    }

    return Text('Failure');
  }

  void onPressed() {
    onPress(exercise);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      child: Container(
        child: NeumorphicButton(
          onPressed: onPressed,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [Text(exercise.title), Text('Sets ${exercise.sets}'), buildRepetitions()],
          ),
        ),
      ),
    );
  }
}
