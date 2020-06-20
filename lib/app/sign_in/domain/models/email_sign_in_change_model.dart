import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter/app/sign_in/domain/models/email_sign_in_model.dart';
import 'package:time_tracker_flutter/app/sign_in/domain/models/validators.dart';
import 'package:time_tracker_flutter/common/domain/repositories/auth_repository.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.type = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  final AuthRepository auth;
  String email;
  String password;
  EmailSignInFormType type;
  bool isLoading;
  bool submitted;

  get primaryButtonText {
    return type == EmailSignInFormType.signIn ? 'Sign in' : 'Create an account';
  }

  get secondaryButtonText {
    return type == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  get passwordErrorText {
    final isTextOk = submitted && !passwordValidator.isValid(password);
    return isTextOk ? invalidPasswordErrorText : null;
  }

  get emailErrorText {
    final isEmailOK = submitted && !emailValidator.isValid(email);
    return isEmailOK ? invalidEmailErrorText : null;
  }

  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);
    try {
      if (type == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        await auth.createUserWithEmailAndPassword(
            email, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleFormType() {
    final type = this.type == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      submitted: false,
      isLoading: false,
      email: '',
      password: '',
      type: type,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateWith({
    String email,
    String password,
    EmailSignInFormType type,
    bool isLoading,
    bool submitted,
  }) {
      this.email = email ?? this.email;
      this.password = password ?? this.password;
      this.type = type ?? this.type;
      this.isLoading = isLoading ?? this.isLoading;
      this.submitted = submitted ?? this.submitted;
      notifyListeners();
  }
}
