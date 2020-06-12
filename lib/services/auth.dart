import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class User {

  User({@required this.uid});

  final String uid;
}

abstract class AuthBase {
  Future<User> currentUser ();
  Future<User> signInAnonymously();
  Future<void> signOut();
}

class Auth implements AuthBase {

  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Future<User> currentUser () async {
    final firebaseUser = await _firebaseAuth.currentUser();
    return _userFromFirebase(firebaseUser);
  }

  @override
  Future<User> signInAnonymously() async {
    final result = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(result.user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}