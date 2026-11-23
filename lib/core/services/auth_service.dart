import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const String _webClientId =
      '623975251939-mctl8bv9hii5g5hpchdn1ppdac1jpeue.apps.googleusercontent.com';

  static bool _googleInitialized = false;

  Future<String?> register(String name, String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await cred.user?.updateDisplayName(name);
      await cred.user?.reload();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return 'unknown';
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        return 'wrong-credentials';
      }
      return e.code;
    } catch (e) {
      return 'unknown';
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return 'unknown';
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      if (!_googleInitialized) {
        await googleSignIn.initialize(serverClientId: _webClientId);
        _googleInitialized = true;
      }
      final account = await googleSignIn.authenticate();
      final auth = account.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
      );
      await _auth.signInWithCredential(credential);
      return null;
    } on GoogleSignInException {
      return 'cancelled';
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return 'unknown';
    }
  }

  Future<void> logout() async {
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
    await _auth.signOut();
  }
}