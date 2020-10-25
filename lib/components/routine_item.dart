import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../providers/routine.dart';

class RoutineItem extends StatelessWidget {
  final Routine routine;
  final Function onPress;

  RoutineItem(this.routine, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NeumorphicButton(
        onPressed: () => onPress(context, routine.id),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          child: Text(
            routine.title,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
