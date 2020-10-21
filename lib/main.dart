import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/workout_provider.dart';
import 'package:gymapp/screens/add_exercise_screen.dart';
import 'package:gymapp/screens/add_routine_screen.dart';
import 'package:gymapp/screens/add_workout_screen.dart';
import 'package:gymapp/screens/home_screen.dart';
import 'package:gymapp/screens/routine_list_screen.dart';
import 'package:gymapp/screens/routine_screen.dart';
import 'package:gymapp/screens/workout_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color base = Color(0xff333a42);
  final Color light = Color(0xff596068);
  final Color dark = Color(0xff0D141C);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoutineProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
      ],
      child: NeumorphicApp(
        title: 'Gym App',
        theme: NeumorphicThemeData(
          intensity: 0.8,
          lightSource: LightSource.topLeft,
          baseColor: base,
          shadowLightColor: light,
          shadowDarkColor: dark,
          shadowLightColorEmboss: light,
          shadowDarkColorEmboss: dark,
        ),
        home: HomeScreen(),
        routes: {
          AddRoutineScreen.routeName: (context) => AddRoutineScreen(),
          RoutineScreen.routeName: (context) => RoutineScreen(),
          WorkoutScreen.routeName: (context) => WorkoutScreen(),
          RoutineListScreen.routeName: (context) => RoutineListScreen(),
          AddWorkoutScreen.routeName: (context) => AddWorkoutScreen(),
          AddExerciseScreen.routeName: (context) => AddExerciseScreen(),
        },
      ),
    );
  }
}
