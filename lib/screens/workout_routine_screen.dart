import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/screens/workout_workout_screen.dart';
import 'package:provider/provider.dart';

import '../components/routine_list.dart';
import '../providers/routine_provider.dart';

class WorkoutRoutineScreen extends StatelessWidget {
  static final String routeName = 'screen/start_workout_routine_screen';

  void onPressItem(context, String id) {
    Navigator.pushNamed(context, WorkoutWorkoutScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    var routines = Provider.of<RoutineProvider>(context).routines;
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text('Select Routine'),
      ),
      body: Container(child: RoutineList(routines, onPressItem)),
    );
  }
}
