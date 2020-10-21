import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/providers/routine.dart';
import 'package:gymapp/screens/routine_screen.dart';

class RoutineItem extends StatelessWidget {
  final Routine routine;

  RoutineItem(this.routine);

  void onPressItem(context) {
    Navigator.pushNamed(context, RoutineScreen.routeName,
        arguments: routine.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NeumorphicButton(
        onPressed: () => onPressItem(context),
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
