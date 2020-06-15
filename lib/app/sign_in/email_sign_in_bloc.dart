import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter/app/sign_in/email_sign_in_model.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
 
  final AuthBase auth;
  final _modelController = StreamController<EmailSignInModel>();

  get modelStream => _modelController.stream;

  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    updateModel(isLoading: true, submittted: true);
    try {
      if (_model.type == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(_model.email, _model.password);
      }
    } catch (e) {
      rethrow;
    } finally {
      updateModel(isLoading: false);
    }
  }

  void updateModel({
    String email,
    String password,
    EmailSignInFormType type,
    bool isLoading,
    bool submittted,
  }) {
    _model = _model.copyWith(
      email: email,
      password: password,
      type: type,
      isLoading: isLoading,
      submitted: submittted,
    );
    _modelController.add(_model);
  }
}
