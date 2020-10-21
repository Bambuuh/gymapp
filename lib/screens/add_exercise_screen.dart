import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AddExerciseScreen extends StatefulWidget {
  static const String routeName = 'screen/add_exercise_screen';

  @override
  _AddExerciseScreenState createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: NeumorphicAppBar(
          title: Text('Add Exercise'),
        ),
      ),
    );
  }
}
