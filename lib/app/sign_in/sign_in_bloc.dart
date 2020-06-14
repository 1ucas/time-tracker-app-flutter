
import 'dart:async';

import 'package:time_tracker_flutter/services/auth.dart';

class SignInBloc {
  SignInBloc(this.auth);
  
  final AuthBase auth;
  final _isLoadingController = StreamController<bool>();



  get isLoadingStream => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      _setIsLoading(false);
      rethrow;
    }
  }

  Future<User> signInAnonymously() async {
    return await _signIn(auth.signInAnonymously);
  }

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

}