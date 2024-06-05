import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  late FirebaseAuth _firebaseAuth;

  AuthService() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  Future<bool> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> registro(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (error) {
      return false;
    }
  }

  String getUserUid(){
    return _firebaseAuth.currentUser?.uid ?? 'not found';
  }


}
