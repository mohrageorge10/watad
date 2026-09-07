import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialAuthService {
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  SocialAuthService({
    GoogleSignIn? googleSignIn,
    FacebookAuth? facebookAuth,
  })  : _googleSignIn = googleSignIn ??
            GoogleSignIn(
              scopes: ['email', 'profile'],
            ),
        _facebookAuth = facebookAuth ?? FacebookAuth.instance;

  /// Signs in with Google and returns the idToken for backend verification.
  /// Returns null if user cancels or authentication fails.
  Future<String?> signInWithGoogle() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        return null;
      }

      final GoogleSignInAuthentication auth = await account.authentication;
      return auth.idToken ?? auth.accessToken;
    } catch (_) {
      return null;
    }
  }

  /// Signs in with Facebook and returns the accessToken for backend verification.
  /// Returns null if user cancels or login fails.
  Future<String?> signInWithFacebook() async {
    try {
      final LoginResult result = await _facebookAuth.login(
        permissions: ['public_profile', 'email'],
      );

      if (result.status == LoginStatus.success && result.accessToken != null) {
        return result.accessToken!.token;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Clears active third-party social auth sessions.
  Future<void> signOut() async {
    try {
      await Future.wait([
        _googleSignIn.signOut(),
        _facebookAuth.logOut(),
      ]);
    } catch (_) {}
  }
}
