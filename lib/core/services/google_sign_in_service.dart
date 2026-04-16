import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final GoogleSignInService _instance =
  GoogleSignInService._internal();

  factory GoogleSignInService() => _instance;

  GoogleSignInService._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
    await _googleSignIn.signIn();

    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'cancelled',
        message: 'User cancelled login',
      );
    }

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance
        .signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'cancelled':
        return 'Login cancelled';
      default:
        return e.message ?? 'Authentication error';
    }
  }
}