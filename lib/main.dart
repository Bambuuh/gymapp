import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/app.dart';
import 'package:gymapp/screens/loading_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('ERROR');
            print(snapshot.error);
            return LoadingScreen();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return GymApp();
          }

          return LoadingScreen();
        });
  }
}
