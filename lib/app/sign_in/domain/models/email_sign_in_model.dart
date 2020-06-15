import 'package:time_tracker_flutter/app/sign_in/domain/models/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.type = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  final String email;
  final String password;
  final EmailSignInFormType type;
  final bool isLoading;
  final bool submitted;

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

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailSignInFormType type,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
