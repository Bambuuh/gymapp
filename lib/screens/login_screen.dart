import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/MorphButton.dart';
import 'package:gymapp/database/exercises_db.dart';
import 'package:gymapp/database/routines_db.dart';
import 'package:gymapp/database/users.dart';
import 'package:gymapp/database/workout_db.dart';
import 'package:gymapp/modules/exercise.dart';
import 'package:gymapp/modules/user.dart';
import 'package:gymapp/providers/exercise_provider.dart';
import 'package:gymapp/providers/routine.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/user_provider.dart';
import 'package:gymapp/providers/workout.dart';
import 'package:gymapp/providers/workout_provider.dart';
import 'package:gymapp/screens/home_screen.dart';
import 'package:gymapp/services/sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> fetchUserData(String userId) async {
    final promises = await Future.wait([
      RoutinesDB.getAllRoutines(userId),
      WorkoutsDB.getAllWorkouts(userId),
      ExercisesDB.getAllExercises(userId),
    ]);
    final result = promises.toList();
    final routines = result[0] as List<Routine>;
    final workouts = result[1] as List<Workout>;
    final exercises = result[2] as List<Exercise>;
    Provider.of<RoutineProvider>(context, listen: false).setRoutines(routines);
    Provider.of<WorkoutProvider>(context, listen: false).setWorkouts(workouts);
    Provider.of<ExerciseProvider>(context, listen: false).setExercises(exercises);
    // routines.forEach((routine) {
    //   Provider.of<RoutineProvider>(context, listen: false).addRoutine(routine);
    // });
    // workouts.forEach((workout) {
    //   Provider.of<WorkoutProvider>(context, listen: false).addWorkout(workout);
    // });
    // exercises.forEach((exercise) {
    //   Provider.of<ExerciseProvider>(context, listen: false).addExercise(exercise);
    // });
  }

  void navigate(context) {
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  Future<void> onPressedGoogleSignIn(context) async {
    final fbUser = await signinWithGoogle();
    if (fbUser != null) {
      User user = await getUser(fbUser.uid);
      if (user == null) {
        user = await createUser(fbUser.uid);
      }
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      fetchUserData(user.id);
      navigate(context);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.init();
      final user = userProvider.user;
      if (user != null) {
        await fetchUserData(user.id);
        navigate(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: NeumorphicAppBar(
          title: Text('Login'),
        ),
        body: Container(
          child: Center(
            child: MorphButton(
              onPressed: () => onPressedGoogleSignIn(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Image(
                      image: AssetImage('assets/google_logo.png'),
                      height: 35,
                    ),
                  ),
                  Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
