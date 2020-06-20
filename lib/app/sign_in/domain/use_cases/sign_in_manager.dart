
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter/common/domain/models/user.dart';
import 'package:time_tracker_flutter/common/domain/repositories/auth_repository.dart';

class SignInManager {
  SignInManager({@required this.auth, @required this.isLoading});
  
  final AuthRepository auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInAnonymously() async {
    return await _signIn(auth.signInAnonymously);
  }

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

}