import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/screens/routine_list_screen.dart';
import 'package:gymapp/screens/workout_routine_screen.dart';

class HomeScreen extends StatelessWidget {
  Widget buildOptionButton(String title, Function onPressed) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      child: NeumorphicButton(
        padding: EdgeInsets.all(16),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: NeumorphicText(
          'Gym App',
          style: NeumorphicStyle(depth: 4, color: Colors.white),
          textStyle: NeumorphicTextStyle(fontSize: 50),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildOptionButton('Start Workout', () => Navigator.of(context).pushNamed(WorkoutRoutineScreen.routeName)),
              buildOptionButton('Routines', () => Navigator.of(context).pushNamed(RoutineListScreen.routeName)),
            ],
          ),
        ),
      ),
    );
  }
}
