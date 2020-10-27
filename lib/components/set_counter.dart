import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/modules/exercise.dart';

class SetCounter extends StatelessWidget {
  final Exercise exercise;

  SetCounter(this.exercise);

  List<Widget> buildRow() {
    List<Widget> dots = [];
    int completed = exercise.completedSets;
    for (int i = 0; i < exercise.sets; i++) {
      Color color = Colors.grey;
      if (completed > 0) {
        completed--;
        color = Colors.green;
      }
      double margin = i > 0 ? 8 : 0;
      dots.add(Container(
        margin: EdgeInsets.only(left: margin),
        height: 8,
        width: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
      ));
    }
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Neumorphic(
        style: NeumorphicStyle(depth: -2),
        padding: EdgeInsets.all(8),
        child: Row(
          children: buildRow(),
        ),
      ),
    );
  }
}
