import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/components/MorphButton.dart';
import 'package:gymapp/modules/user.dart';
import 'package:gymapp/screens/home_screen.dart';
import 'package:gymapp/services/database/users.dart';
import 'package:gymapp/services/sign_in.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> onPressedGoogleSignIn() async {
    final fbUser = await signinWithGoogle();
    if (fbUser != null) {
      User user = await getUser(fbUser.uid);
      if (user == null) {
        user = await createUser(fbUser.uid);
      }

      Navigator.of(context).pushNamed(HomeScreen.routeName);
    }
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
              onPressed: onPressedGoogleSignIn,
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
