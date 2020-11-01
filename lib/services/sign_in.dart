import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User> signinWithGoogle() async {
  final googleSignInAccount = await googleSignIn.signIn();
  final googleSignInAuthentication = await googleSignInAccount.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final authResult = await _auth.signInWithCredential(credential);
  final user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    return user;
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print('Logged out');
}
