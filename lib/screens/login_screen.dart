import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/MorphButton.dart';
import 'package:gymapp/database/routines_db.dart';
import 'package:gymapp/database/users.dart';
import 'package:gymapp/modules/user.dart';
import 'package:gymapp/providers/routine_provider.dart';
import 'package:gymapp/providers/user_provider.dart';
import 'package:gymapp/screens/home_screen.dart';
import 'package:gymapp/services/sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void fetchUserData(String userId) async {
    final routines = await getRoutines(userId);
    routines.forEach((routine) {
      Provider.of<RoutineProvider>(context, listen: false).addRoutine(routine);
    });
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
        fetchUserData(user.id);
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
