import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/sign_in/ui/email_sign_in/email_sign_in_form_stateful.dart';
import 'package:time_tracker_flutter/common/domain/models/user.dart';
import 'package:time_tracker_flutter/common/domain/repositories/auth_repository.dart';
import 'mocks_util.dart';

void main() {
  MockAuth mockAuth;

  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpEmailSignInForm(WidgetTester tester,
      {VoidCallback onSignedIn}) async {
    await tester.pumpWidget(
      Provider<AuthRepository>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: Scaffold(
            body: EmailSignInFormStateful(
              onSignedIn: onSignedIn,
            ),
          ),
        ),
      ),
    );
  }

  void stubSignInSucceeds() {
    when(mockAuth.signInWithEmailAndPassword(any, any))
        .thenAnswer((realInvocation) {
      return Future<User>.value(User(uid: '123'));
    });
  }

  void stubSignInThrowsError() {
    when(mockAuth.signInWithEmailAndPassword(any, any)).thenThrow(
      PlatformException(
        code: 'ERROR_WRONG_PASSWORD',
      ),
    );
  }

  group('Sign In', () {
    testWidgets(
        'QUANDO o usuário não inserir email e password '
        'E clicar no botão Sign In '
        'ENTÃO o botão não deve ser acionado '
        'E o usuário não é logado ', (WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
      expect(signedIn, false);
    });

    testWidgets(
        'QUANDO o usuário inserir um email e password validos '
        'E clicar no botão Sign In '
        'ENTÃO o botão deve ser acionado '
        'E o usuário é logado', (WidgetTester tester) async {
      // Inicializa a tela
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);

      // Retorna sucesso ao fazer login
      stubSignInSucceeds();

      const email = 'email@email.com';
      const password = 'password';

      // Preenche valores nos TextFields
      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passswordField = find.byKey(Key('password'));
      expect(passswordField, findsOneWidget);
      await tester.enterText(passswordField, password);

      // Atualiza a interface - "Rebuild"
      await tester.pump(); // se tiver animações, pumpAndSettle

      // Clica no botão de Login
      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
      expect(signedIn, true);
    });

    testWidgets(
        'QUANDO o usuário inserir um email e password inválido '
        'E clicar no botão Sign In '
        'ENTÃO o botão deve ser acionado '
        'E o usuário não é logado', (WidgetTester tester) async {
      // Inicializa a tela
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);

      // Retorna sucesso ao fazer login
      stubSignInThrowsError();

      const email = 'email@email.com';
      const password = 'password';

      // Preenche valores nos TextFields
      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passswordField = find.byKey(Key('password'));
      expect(passswordField, findsOneWidget);
      await tester.enterText(passswordField, password);

      // Atualiza a interface - "Rebuild"
      await tester.pump(); // se tiver animações, pumpAndSettle

      // Clica no botão de Login
      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
      expect(signedIn, false);
    });
  });

  group('Register', () {
    testWidgets(
        'QUANDO o usuário clicar em Registrar '
        'ENTÃO o formulário alterna para Cadastro',
        (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);
      final registerButton = find.text('Need an account? Register');
      await tester.tap(registerButton);

      await tester.pump();

      final createAccountButton = find.text('Create an account');
      expect(createAccountButton, findsOneWidget);
    });

    testWidgets(
        'Quando o usuário clicar no botão de Cadastro '
        'E o usuário inserir email e password '
        'E clicar no botão Register '
        'ENTÃO deve ser chamada a função de cadastro',
        (WidgetTester tester) async {
      // Inicializa a tela
      await pumpEmailSignInForm(tester);

      const email = 'email@email.com';
      const password = 'password';

      // Entra no modo de cadastro
      final registerButton = find.text('Need an account? Register');
      await tester.tap(registerButton);

      // Atualiza a interface - "Rebuild"
      await tester.pump();

      // Preenche valores nos TextFields
      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passswordField = find.byKey(Key('password'));
      expect(passswordField, findsOneWidget);
      await tester.enterText(passswordField, password);

      // Atualiza a interface - "Rebuild"
      await tester.pump(); // se tiver animações, pumpAndSettle

      // Clica no botão de Cadastro
      final createAccountButton = find.text('Create an account');
      expect(createAccountButton, findsOneWidget);
      await tester.tap(createAccountButton);

      verify(mockAuth.createUserWithEmailAndPassword(email, password))
          .called(1);
    });
  });
}
