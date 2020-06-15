enum EmailSignInFormType { signIn, register }

class EmailSignInModel {
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
