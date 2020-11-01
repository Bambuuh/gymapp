import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/providers/exercise_provider.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/user_provider.dart';
import 'package:gymapp/providers/workout_provider.dart';
import 'package:gymapp/screens/add_exercise_screen.dart';
import 'package:gymapp/screens/add_routine_screen.dart';
import 'package:gymapp/screens/add_workout_screen.dart';
import 'package:gymapp/screens/home_screen.dart';
import 'package:gymapp/screens/login_screen.dart';
import 'package:gymapp/screens/rest_screen.dart';
import 'package:gymapp/screens/routine_list_screen.dart';
import 'package:gymapp/screens/routine_screen.dart';
import 'package:gymapp/screens/select_repetitions_screen.dart';
import 'package:gymapp/screens/select_weight_screen.dart';
import 'package:gymapp/screens/workout_exercise_screen.dart';
import 'package:gymapp/screens/workout_routine_screen.dart';
import 'package:gymapp/screens/workout_screen.dart';
import 'package:gymapp/screens/workout_workout_screen.dart';
import 'package:provider/provider.dart';

class GymApp extends StatelessWidget {
  final Color base = Color(0xff333a42);
  final Color light = Color(0xff4D545C);
  final Color dark = Color(0xff1A2129);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoutineProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => ExerciseProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
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
        home: LoginScreen(),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          AddRoutineScreen.routeName: (context) => AddRoutineScreen(),
          WorkoutRoutineScreen.routeName: (context) => WorkoutRoutineScreen(),
          WorkoutWorkoutScreen.routeName: (context) => WorkoutWorkoutScreen(),
          WorkoutExerciseScreen.routeName: (context) => WorkoutExerciseScreen(),
          RoutineScreen.routeName: (context) => RoutineScreen(),
          WorkoutScreen.routeName: (context) => WorkoutScreen(),
          RoutineListScreen.routeName: (context) => RoutineListScreen(),
          AddWorkoutScreen.routeName: (context) => AddWorkoutScreen(),
          AddExerciseScreen.routeName: (context) => AddExerciseScreen(),
          SelectRepetitionsScreen.routeName: (context) => SelectRepetitionsScreen(),
          SelectWeightScreen.routeName: (context) => SelectWeightScreen(),
          RestScreen.routeName: (context) => RestScreen(),
        },
      ),
    );
  }
}
