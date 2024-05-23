import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getUserEmail() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.reload();
        user = _auth.currentUser;
        if (user != null) {
          return user.email;
        }
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
