import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/sign_in/ui/email_sign_in/email_sign_in_form_stateful.dart';
import 'package:time_tracker_flutter/common/domain/repositories/auth_repository.dart';

class MockAuth extends Mock implements AuthRepository {}

void main() {
  MockAuth mockAuth;

  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpEmailSignInForm(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthRepository>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: Scaffold(
            body: EmailSignInFormStateful(),
          ),
        ),
      ),
    );
  }

  group('Sign In', () {
    testWidgets(
        'QUANDO o usuário não inserir email e password '
        'E clicar no botão Sign In '
        'ENTÃO o botão não deve ser acionado', (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);
      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
    });

    testWidgets(
        'QUANDO o usuário inserir email e password '
        'E clicar no botão Sign In '
        'ENTÃO o botão deve ser acionado', (WidgetTester tester) async {
      // Inicializa a tela
      await pumpEmailSignInForm(tester);

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
    });
  });


  group('Register', () {
    testWidgets(
        'QUANDO o usuário clicar em Registrar '
        'ENTÃO o formulário alterna para Cadastro', (WidgetTester tester) async {
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
        'ENTÃO deve ser chamada a função de cadastro', (WidgetTester tester) async {
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

      verify(mockAuth.createUserWithEmailAndPassword(email, password)).called(1);
    });
  });
}
