import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleSignIn _googleSignIn;
  GoogleAuthService() {
    _googleSignIn = GoogleSignIn();
  }

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
    return;
  }

  Future<bool> isLoggedIn() async {
    return _googleSignIn.isSignedIn();
  }

  Future<GoogleSignInAccount> getLoggedUser() async {
    return _googleSignIn.currentUser;
  }
}

final googleAuthService = GoogleAuthService();
