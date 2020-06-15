import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/sign_in/email_sign_in_bloc.dart';
import 'package:time_tracker_flutter/app/sign_in/email_sign_in_model.dart';
import 'package:time_tracker_flutter/app/sign_in/validators.dart';
import 'package:time_tracker_flutter/common_widgets/form_submit_buttom.dart';
import 'package:time_tracker_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class EmailSignInFormBlocBased extends StatefulWidget
    with EmailAndPasswordValidators {
  EmailSignInFormBlocBased({@required this.bloc});

  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return Provider<EmailSignInBloc>(
      create: (context) => EmailSignInBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<EmailSignInBloc>(
        builder: (context, bloc, _) => EmailSignInFormBlocBased(
          bloc: bloc,
        ),
      ),
    );
  }

  @override
  EmailSignInFormStatefulState createState() => EmailSignInFormStatefulState();
}

class EmailSignInFormStatefulState extends State<EmailSignInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        exception: e,
        title: 'Sign in failed',
      ).show(context);
    }
  }

  void _toggleFormType(EmailSignInModel model) {
    widget.bloc.updateModel(
      submittted: false,
      isLoading: false,
      email: '',
      password: '',
      type: model.type == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,
    );
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = widget.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    final primaryText = model.type == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText = model.type == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    final submitEnabled = widget.emailValidator.isValid(model.email) &&
        widget.passwordValidator.isValid(model.password) &&
        !model.isLoading;

    return [
      _buildEmailTextField(model),
      SizedBox(height: 8.0),
      _buildPasswordTextField(model),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      FlatButton(
        child: Text(secondaryText),
        onPressed: model.isLoading ? null : () => _toggleFormType(model),
      )
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    bool showErrorText =
        model.submitted && !widget.passwordValidator.isValid(model.password);
    return TextField(
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      onChanged: (password) => widget.bloc.updateModel(password: password),
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    bool showErrorText =
        model.submitted && !widget.emailValidator.isValid(model.email);
    return TextField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: model.isLoading == false,
      ),
      controller: _emailController,
      focusNode: _emailFocusNode,
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => widget.bloc.updateModel(email: email),
      onEditingComplete: () => _emailEditingComplete(model),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final emailSignInModel = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: _buildChildren(emailSignInModel),
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          );
        });
  }
}
