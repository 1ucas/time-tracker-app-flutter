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
        'QUANDO o usuário não inserir email e password'
        'E clicar no botão Sign In'
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

      // Clica no botão
      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
    });
  });
}
