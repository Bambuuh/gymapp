import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/routine_item.dart';
import 'package:gymapp/providers/routine.dart';

class RoutineList extends StatelessWidget {
  final List<Routine> routines;
  final Function onPressItem;

  RoutineList(this.routines, this.onPressItem);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: routines.map((routine) => RoutineItem(routine, onPressItem)).toList(),
    );
  }
}
